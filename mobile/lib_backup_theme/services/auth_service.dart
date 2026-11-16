import 'dart:convert';
import 'package:dio/dio.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../core/utils/app_preferences.dart';
import '../models/user_model.dart';

class AuthException implements Exception {
  final String message;
  final String? code;
  const AuthException(this.message, {this.code});

  @override
  String toString() => message;
}

class AuthService {
  final ApiClient _client = ApiClient();
  static const String userPrefKey = 'direct_job_cached_user';
  static const String registeredAccountsPrefKey = 'direct_job_registered_accounts_v2';

  // --------------------------------------------------------------------------
  // PHONE & EMAIL NORMALIZATION
  // --------------------------------------------------------------------------
  static String normalizeEmail(String email) => email.trim().toLowerCase();

  static String normalizePhone(String phone) {
    String digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('00965')) {
      digits = digits.substring(5);
    } else if (digits.startsWith('965') && digits.length > 8) {
      digits = digits.substring(3);
    }
    return digits;
  }

  // --------------------------------------------------------------------------
  // REGISTERED ACCOUNTS PERSISTENCE
  // --------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>> _getRegisteredAccounts() async {
    try {
      final raw = await AppPreferences.getString(registeredAccountsPrefKey);
      if (raw != null && raw.isNotEmpty) {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
        }
      }
    } catch (_) {}
    return [];
  }

  Future<void> _saveRegisteredAccount({
    required String email,
    required String phone,
    required String password,
    required UserModel user,
  }) async {
    try {
      final accounts = await _getRegisteredAccounts();
      final normEmail = normalizeEmail(email);
      final normPhone = normalizePhone(phone);

      // Remove any existing record with same email or phone to update cleanly
      accounts.removeWhere((acc) {
        final e = normalizeEmail(acc['email']?.toString() ?? '');
        final p = normalizePhone(acc['phone']?.toString() ?? '');
        return e == normEmail || (normPhone.isNotEmpty && p == normPhone);
      });

      accounts.add({
        'id': user.id,
        'email': email.trim(),
        'normalized_email': normEmail,
        'phone': phone.trim(),
        'normalized_phone': normPhone,
        'password': password,
        'role': user.role.toApiString(),
        'user': user.toJson(),
        'created_at': DateTime.now().toIso8601String(),
      });

      await AppPreferences.setString(registeredAccountsPrefKey, jsonEncode(accounts));
    } catch (_) {}
  }

  Future<void> _removeRegisteredAccount(String email, String phone) async {
    try {
      final accounts = await _getRegisteredAccounts();
      final normEmail = normalizeEmail(email);
      final normPhone = normalizePhone(phone);

      accounts.removeWhere((acc) {
        final e = normalizeEmail(acc['email']?.toString() ?? '');
        final p = normalizePhone(acc['phone']?.toString() ?? '');
        return e == normEmail || (normPhone.isNotEmpty && p == normPhone);
      });

      await AppPreferences.setString(registeredAccountsPrefKey, jsonEncode(accounts));
    } catch (_) {}
  }

  // --------------------------------------------------------------------------
  // USER CACHE & ACTIVE SESSION
  // --------------------------------------------------------------------------
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = await AppPreferences.getString(userPrefKey);
      if (userJson != null && userJson.isNotEmpty) {
        try {
          final decoded = jsonDecode(userJson);
          if (decoded is Map<String, dynamic>) {
            return UserModel.fromJson(decoded);
          } else if (decoded is Map) {
            return UserModel.fromJson(Map<String, dynamic>.from(decoded));
          }
        } catch (_) {}
      }
    } catch (_) {}
    return null;
  }

  Future<void> cacheUser(UserModel user) async {
    await _cacheUser(user);
  }

  Future<void> _cacheUser(UserModel user) async {
    try {
      final jsonStr = jsonEncode(user.toJson());
      await AppPreferences.setString(userPrefKey, jsonStr);
      await AppPreferences.setBool('onboarding_completed', true);
      await AppPreferences.setBool('is_logged_in', true);
      await AppPreferences.setString('cached_user_role', user.role.toApiString());
    } catch (_) {}
  }

  // --------------------------------------------------------------------------
  // BULLETPROOF LOGIN (No Ghost / No Automatic Registrations)
  // --------------------------------------------------------------------------
  Future<UserModel> login({required String loginId, required String password}) async {
    final cleanInput = loginId.trim();
    final normEmail = normalizeEmail(cleanInput);
    final normPhone = normalizePhone(cleanInput);

    if (cleanInput.isEmpty || password.isEmpty) {
      throw const AuthException(
        'يرجى إدخال البريد الإلكتروني أو رقم الهاتف وكلمة المرور.',
        code: 'missing_credentials',
      );
    }

    // 1. Attempt Live Server Authentication
    try {
      final response = await _client.dio.post(
        ApiEndpoints.login,
        data: {'login': cleanInput, 'password': password},
      );
      if (response.data != null && response.data['data'] != null) {
        final token = response.data['token'] ?? response.data['data']['token'];
        if (token != null) {
          await _client.saveToken(token.toString());
        }
        final userData = response.data['data']['user'] ?? response.data['data'];
        final user = UserModel.fromJson(Map<String, dynamic>.from(userData));
        await _cacheUser(user);
        await _saveRegisteredAccount(
          email: user.email,
          phone: user.phone,
          password: password,
          user: user,
        );
        return user;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with an explicit rejection (400, 401, 404, 422)
        final data = e.response?.data;
        String? serverMsg;
        if (data is Map) {
          serverMsg = data['message']?.toString() ?? data['error']?.toString();
          if (data['errors'] is Map) {
            final errors = data['errors'] as Map;
            final firstList = errors.values.first;
            if (firstList is List && firstList.isNotEmpty) {
              serverMsg = firstList.first.toString();
            }
          }
        }
        // Explicit rejection: stop immediately, do not fall back to ghost users
        throw AuthException(
          serverMsg ?? 'بيانات الدخول غير صحيحة. يرجى التحقق من البريد أو رقم الهاتف وكلمة المرور.',
          code: 'invalid_credentials',
        );
      }
      // If e.response == null, server is unreachable or offline -> verify local registered accounts
    }

    // 2. Offline / Local Authentication against Verified Registered Accounts
    final registered = await _getRegisteredAccounts();
    Map<String, dynamic>? matchingAccount;

    for (final acc in registered) {
      final accEmail = normalizeEmail(acc['email']?.toString() ?? '');
      final accPhone = normalizePhone(acc['phone']?.toString() ?? '');
      final accRawPhone = (acc['phone']?.toString() ?? '').replaceAll(RegExp(r'\D'), '');
      final inputRaw = cleanInput.replaceAll(RegExp(r'\D'), '');

      final emailMatch = accEmail.isNotEmpty && accEmail == normEmail;
      final phoneMatch = normPhone.isNotEmpty && (accPhone == normPhone || (inputRaw.isNotEmpty && accRawPhone == inputRaw));

      if (emailMatch || phoneMatch) {
        matchingAccount = acc;
        break;
      }
    }

    // Check cached user if registered accounts list was empty
    if (matchingAccount == null) {
      final cached = await getCachedUser();
      if (cached != null) {
        final cEmail = normalizeEmail(cached.email);
        final cPhone = normalizePhone(cached.phone);
        final cRaw = cached.phone.replaceAll(RegExp(r'\D'), '');
        final inputRaw = cleanInput.replaceAll(RegExp(r'\D'), '');

        if ((cEmail.isNotEmpty && cEmail == normEmail) ||
            (normPhone.isNotEmpty && (cPhone == normPhone || (inputRaw.isNotEmpty && cRaw == inputRaw)))) {
          matchingAccount = {
            'email': cached.email,
            'phone': cached.phone,
            'password': null, // check if any password was cached
            'user': cached.toJson(),
          };
        }
      }
    }

    // If no registered account found: REJECT LOGIN! Do not auto-create!
    if (matchingAccount == null) {
      throw const AuthException(
        'لم يتم العثور على حساب مسجل بهذا البريد الإلكتروني أو رقم الهاتف. يرجى إنشاء حساب جديد أولاً.',
        code: 'user_not_found',
      );
    }

    // Verify Password if stored locally
    final storedPassword = matchingAccount['password']?.toString();
    if (storedPassword != null && storedPassword.isNotEmpty && storedPassword != password) {
      throw const AuthException(
        'كلمة المرور غير صحيحة. يرجى التأكد من البيانات والمحاولة مجدداً.',
        code: 'wrong_password',
      );
    }

    // Success -> log in with the verified registered account
    final userJson = matchingAccount['user'];
    final user = UserModel.fromJson(Map<String, dynamic>.from(userJson as Map));
    await _client.saveToken('local_token_${DateTime.now().millisecondsSinceEpoch}');
    await _cacheUser(user);
    return user;
  }

  // --------------------------------------------------------------------------
  // BULLETPROOF APPLICANT REGISTRATION (Strict Uniqueness Check)
  // --------------------------------------------------------------------------
  Future<UserModel> registerApplicant({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    String? governorate,
    String? profession,
    String? nationality,
    String? countryOfResidence,
    int? experienceYears,
    String? bio,
  }) async {
    final normEmail = normalizeEmail(email);
    final normPhone = normalizePhone(phone);

    // 1. Check local registered accounts for existing duplicate
    final registered = await _getRegisteredAccounts();
    for (final acc in registered) {
      final e = normalizeEmail(acc['email']?.toString() ?? '');
      final p = normalizePhone(acc['phone']?.toString() ?? '');

      if (e.isNotEmpty && e == normEmail) {
        throw const AuthException(
          'البريد الإلكتروني مسجل بالفعل في المنصة. يرجى تسجيل الدخول إلى حسابك.',
          code: 'email_already_registered',
        );
      }
      if (normPhone.isNotEmpty && p == normPhone) {
        throw const AuthException(
          'رقم الهاتف مسجل بالفعل في المنصة. يرجى تسجيل الدخول إلى حسابك.',
          code: 'phone_already_registered',
        );
      }
    }

    // Also check cached user
    final cached = await getCachedUser();
    if (cached != null) {
      if (normalizeEmail(cached.email) == normEmail) {
        throw const AuthException(
          'البريد الإلكتروني مسجل بالفعل. يرجى تسجيل الدخول.',
          code: 'email_already_registered',
        );
      }
      if (normPhone.isNotEmpty && normalizePhone(cached.phone) == normPhone) {
        throw const AuthException(
          'رقم الهاتف مسجل بالفعل. يرجى تسجيل الدخول.',
          code: 'phone_already_registered',
        );
      }
    }

    // 2. Attempt Backend API Registration
    final payload = {
      'full_name': fullName.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'password': password,
      'role': 'applicant',
      'governorate': governorate ?? 'محافظة العاصمة',
      'profession': profession ?? 'عام',
      'nationality': nationality ?? 'Kuwait',
      'country_of_residence': countryOfResidence ?? 'Kuwait',
      'experience_years': experienceYears,
      'bio': bio,
    };

    try {
      final response = await _client.dio.post(ApiEndpoints.register, data: payload);
      if (response.data != null && response.data['data'] != null) {
        final token = response.data['token'];
        if (token != null) await _client.saveToken(token.toString());
        final user = UserModel.fromJson(Map<String, dynamic>.from(response.data['data']));
        await _cacheUser(user);
        await _saveRegisteredAccount(
          email: user.email,
          phone: user.phone,
          password: password,
          user: user,
        );
        return user;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        String? message;
        if (data is Map) {
          message = data['message']?.toString();
          if (data['errors'] is Map) {
            final errors = data['errors'] as Map;
            if (errors.containsKey('email')) {
              throw const AuthException(
                'البريد الإلكتروني مسجل بالفعل. يرجى استخدام بريد آخر أو تسجيل الدخول.',
                code: 'email_already_registered',
              );
            }
            if (errors.containsKey('phone')) {
              throw const AuthException(
                'رقم الهاتف مسجل بالفعل. يرجى استخدام رقم آخر أو تسجيل الدخول.',
                code: 'phone_already_registered',
              );
            }
            final firstList = errors.values.first;
            if (firstList is List && firstList.isNotEmpty) {
              message = firstList.first.toString();
            }
          }
        }
        throw AuthException(
          message ?? 'فشل إنشاء الحساب. قد يكون البريد الإلكتروني أو الهاتف مسجلاً مسبقاً.',
          code: 'registration_rejected',
        );
      }
      // If server unreachable/offline, local registration proceeds because uniqueness check passed
    }

    // 3. Complete verified local registration
    final newUser = UserModel(
      id: 'kw_user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: email.trim(),
      phone: phone.trim(),
      role: UserRole.applicant,
      governorate: governorate ?? 'محافظة العاصمة',
      profession: profession ?? 'عام',
      nationality: nationality ?? 'Kuwait',
      countryOfResidence: countryOfResidence ?? 'Kuwait',
      experienceYears: experienceYears ?? 1,
      bio: bio ?? '',
      isVerified: true,
    );

    await _client.saveToken('local_applicant_token_${DateTime.now().millisecondsSinceEpoch}');
    await _cacheUser(newUser);
    await _saveRegisteredAccount(
      email: newUser.email,
      phone: newUser.phone,
      password: password,
      user: newUser,
    );
    return newUser;
  }

  // --------------------------------------------------------------------------
  // BULLETPROOF COMPANY REGISTRATION (Strict Uniqueness Check)
  // --------------------------------------------------------------------------
  Future<UserModel> registerCompany({
    required String companyName,
    required String contactPerson,
    required String email,
    required String phone,
    required String password,
    required String commercialLicense,
    required String governorate,
  }) async {
    final normEmail = normalizeEmail(email);
    final normPhone = normalizePhone(phone);

    // 1. Check local registered accounts for existing duplicate
    final registered = await _getRegisteredAccounts();
    for (final acc in registered) {
      final e = normalizeEmail(acc['email']?.toString() ?? '');
      final p = normalizePhone(acc['phone']?.toString() ?? '');

      if (e.isNotEmpty && e == normEmail) {
        throw const AuthException(
          'البريد الإلكتروني مسجل بالفعل لشركة أخرى. يرجى تسجيل الدخول أو استخدام بريد مختلف.',
          code: 'email_already_registered',
        );
      }
      if (normPhone.isNotEmpty && p == normPhone) {
        throw const AuthException(
          'رقم الهاتف مسجل بالفعل. يرجى تسجيل الدخول أو استخدام رقم آخر.',
          code: 'phone_already_registered',
        );
      }
    }

    // Check cached user
    final cached = await getCachedUser();
    if (cached != null) {
      if (normalizeEmail(cached.email) == normEmail) {
        throw const AuthException(
          'البريد الإلكتروني مسجل بالفعل. يرجى تسجيل الدخول.',
          code: 'email_already_registered',
        );
      }
    }

    // 2. Attempt Backend API Registration
    final payload = {
      'company_name': companyName.trim(),
      'full_name': contactPerson.trim(),
      'email': email.trim(),
      'phone': phone.trim(),
      'password': password,
      'commercial_license': commercialLicense.trim(),
      'governorate': governorate,
      'role': 'company',
    };

    try {
      final response = await _client.dio.post(ApiEndpoints.registerCompany, data: payload);
      if (response.data != null && response.data['data'] != null) {
        final token = response.data['token'];
        if (token != null) await _client.saveToken(token.toString());
        final user = UserModel.fromJson(Map<String, dynamic>.from(response.data['data']));
        await _cacheUser(user);
        await _saveRegisteredAccount(
          email: user.email,
          phone: user.phone,
          password: password,
          user: user,
        );
        return user;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response?.data;
        String? message;
        if (data is Map) {
          message = data['message']?.toString();
          if (data['errors'] is Map) {
            final errors = data['errors'] as Map;
            if (errors.containsKey('email')) {
              throw const AuthException(
                'البريد الإلكتروني مسجل بالفعل للشركة. يرجى تسجيل الدخول.',
                code: 'email_already_registered',
              );
            }
            if (errors.containsKey('phone')) {
              throw const AuthException(
                'رقم الهاتف مسجل بالفعل. يرجى استخدام رقم آخر.',
                code: 'phone_already_registered',
              );
            }
            final firstList = errors.values.first;
            if (firstList is List && firstList.isNotEmpty) {
              message = firstList.first.toString();
            }
          }
        }
        throw AuthException(
          message ?? 'فشل تسجيل الشركة. قد يكون البريد الإلكتروني مسجلاً مسبقاً.',
          code: 'registration_rejected',
        );
      }
      // If server unreachable/offline, local registration proceeds
    }

    // 3. Complete verified local registration
    final newCompany = UserModel(
      id: 'kw_company_${DateTime.now().millisecondsSinceEpoch}',
      fullName: contactPerson.trim(),
      companyName: companyName.trim(),
      commercialLicense: commercialLicense.trim(),
      email: email.trim(),
      phone: phone.trim(),
      role: UserRole.company,
      governorate: governorate,
      isVerified: true,
    );

    await _client.saveToken('local_company_token_${DateTime.now().millisecondsSinceEpoch}');
    await _cacheUser(newCompany);
    await _saveRegisteredAccount(
      email: newCompany.email,
      phone: newCompany.phone,
      password: password,
      user: newCompany,
    );
    return newCompany;
  }

  Future<bool> verifyOtp(String code) async {
    try {
      final response = await _client.dio.post(ApiEndpoints.verifyOtp, data: {'code': code});
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _client.dio
          .post(ApiEndpoints.logout)
          .timeout(const Duration(seconds: 2));
    } catch (_) {}
    await _client.clearToken();
    try {
      await AppPreferences.remove(userPrefKey);
      await AppPreferences.setBool('is_logged_in', false);
      await AppPreferences.remove('cached_user_role');
    } catch (_) {}
  }

  Future<void> deleteAccount() async {
    try {
      final user = await getCachedUser();
      if (user != null) {
        await _removeRegisteredAccount(user.email, user.phone);
      }
      await _client.dio
          .delete(ApiEndpoints.deleteAccount)
          .timeout(const Duration(seconds: 2));
    } catch (_) {}
    await logout();
  }
}

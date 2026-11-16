import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/utils/app_preferences.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? errorMessage;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(const AuthState()) {
    checkCachedUser();
  }

  void setUser(UserModel? user) {
    state = state.copyWith(user: user, isAuthenticated: user != null);
  }

  Future<void> checkCachedUser() async {
    state = state.copyWith(isLoading: true);
    final user = await _service.getCachedUser();
    final isLoggedIn = (await AppPreferences.getBool('is_logged_in')) ?? false;
    if (user != null && isLoggedIn) {
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        user: null,
        isAuthenticated: false,
        isLoading: false,
      );
    }
  }

  Future<bool> login(String loginId, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _service.login(loginId: loginId, password: password);
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
        errorMessage: null,
      );
      return true;
    } catch (e) {
      final message = e is AuthException
          ? e.message
          : (e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception:', '').trim()
              : 'فشل تسجيل الدخول. يرجى التحقق من صحة البيانات.');
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
      return false;
    }
  }

  Future<bool> registerApplicant({
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
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _service.registerApplicant(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        governorate: governorate,
        profession: profession,
        nationality: nationality,
        countryOfResidence: countryOfResidence,
        experienceYears: experienceYears,
        bio: bio,
      );
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
        errorMessage: null,
      );
      return true;
    } catch (e) {
      final message = e is AuthException
          ? e.message
          : (e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception:', '').trim()
              : 'حدث خطأ أثناء التسجيل. يرجى المحاولة مجدداً.');
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
      return false;
    }
  }

  Future<bool> registerCompany({
    required String companyName,
    required String contactPerson,
    required String email,
    required String phone,
    required String password,
    required String commercialLicense,
    required String governorate,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _service.registerCompany(
        companyName: companyName,
        contactPerson: contactPerson,
        email: email,
        phone: phone,
        password: password,
        commercialLicense: commercialLicense,
        governorate: governorate,
      );
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
        errorMessage: null,
      );
      return true;
    } catch (e) {
      final message = e is AuthException
          ? e.message
          : (e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception:', '').trim()
              : 'فشل تسجيل الشركة. يرجى التحقق من صحة البيانات.');
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    state = const AuthState();
  }

  Future<void> deleteAccount() async {
    await _service.deleteAccount();
    state = const AuthState();
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

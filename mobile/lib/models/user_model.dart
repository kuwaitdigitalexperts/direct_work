enum UserRole {
  applicant,
  company,
  advertiser;

  static UserRole fromString(String? role) {
    switch (role?.toLowerCase()) {
      case 'company':
        return UserRole.company;
      case 'advertiser':
        return UserRole.advertiser;
      case 'applicant':
      default:
        return UserRole.applicant;
    }
  }

  String toApiString() {
    switch (this) {
      case UserRole.company:
        return 'company';
      case UserRole.advertiser:
        return 'advertiser';
      case UserRole.applicant:
        return 'applicant';
    }
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final UserRole role;
  final String? governorate;
  final String? nationality;
  final String? countryOfResidence;
  final String? profession;
  final int? experienceYears;
  final String? bio;
  final String? cvUrl;
  final String? companyName;
  final String? commercialLicense;
  final String? avatarUrl;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.governorate,
    this.nationality,
    this.countryOfResidence,
    this.profession,
    this.experienceYears,
    this.bio,
    this.cvUrl,
    this.companyName,
    this.commercialLicense,
    this.avatarUrl,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      fullName: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: UserRole.fromString(json['role']),
      governorate: json['governorate'],
      nationality: json['nationality'],
      countryOfResidence: json['country_of_residence'] ?? json['country'],
      profession: json['profession'],
      experienceYears: json['experience_years'] != null
          ? int.tryParse(json['experience_years'].toString())
          : null,
      bio: json['bio'],
      cvUrl: json['cv_url'],
      companyName: json['company_name'],
      commercialLicense: json['commercial_license'],
      avatarUrl: json['avatar_url'],
      isVerified: json['is_verified'] == true || json['is_verified'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'role': role.toApiString(),
      'governorate': governorate,
      'nationality': nationality,
      'country_of_residence': countryOfResidence,
      'profession': profession,
      'experience_years': experienceYears,
      'bio': bio,
      'cv_url': cvUrl,
      'company_name': companyName,
      'commercial_license': commercialLicense,
      'avatar_url': avatarUrl,
      'is_verified': isVerified,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    UserRole? role,
    String? governorate,
    String? nationality,
    String? countryOfResidence,
    String? profession,
    int? experienceYears,
    String? bio,
    String? cvUrl,
    String? companyName,
    String? commercialLicense,
    String? avatarUrl,
    bool? isVerified,
  }) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      governorate: governorate ?? this.governorate,
      nationality: nationality ?? this.nationality,
      countryOfResidence: countryOfResidence ?? this.countryOfResidence,
      profession: profession ?? this.profession,
      experienceYears: experienceYears ?? this.experienceYears,
      bio: bio ?? this.bio,
      cvUrl: cvUrl ?? this.cvUrl,
      companyName: companyName ?? this.companyName,
      commercialLicense: commercialLicense ?? this.commercialLicense,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  /// Checks whether user resides inside Kuwait and has a local phone number starting with (+965).
  bool get isInsideKuwait {
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final country = (countryOfResidence ?? '').trim().toLowerCase();

    // 1. If country of residence is specified and is NOT Kuwait, user is outside Kuwait
    if (country.isNotEmpty &&
        !country.contains('kuwait') &&
        !country.contains('كويت')) {
      return false;
    }

    // 2. Reject foreign calling codes
    const foreignCodes = [
      '+92', '0092', // Pakistan
      '+91', '0091', // India
      '+20', '0020', // Egypt
      '+880', '00880', // Bangladesh
      '+63', '0063', // Philippines
      '+966', '00966', // Saudi Arabia
      '+971', '00971', // UAE
      '+962', '00962', // Jordan
      '+961', '00961', // Lebanon
      '+964', '00964', // Iraq
      '+968', '00968', // Oman
      '+974', '00974', // Qatar
      '+973', '00973', // Bahrain
      '+977', '00977', // Nepal
      '+94', '0094', // Sri Lanka
      '+249', '00249', // Sudan
      '+967', '00967', // Yemen
      '+963', '00963', // Syria
      '+212', '00212', // Morocco
      '+216', '00216', // Tunisia
      '+213', '00213', // Algeria
      '+1', // USA / Canada
      '+44', // UK
      '+49', // Germany
      '+33', // France
      '+90', // Turkey
    ];
    for (final code in foreignCodes) {
      if (cleanPhone.startsWith(code)) {
        return false;
      }
    }

    // 3. Must be a valid Kuwait phone (+965, 00965, 965 followed by 8 digits, or local 8-digit starting with 5, 6, 9)
    final isKuwaitPhone = cleanPhone.startsWith('+965') ||
        cleanPhone.startsWith('00965') ||
        (cleanPhone.startsWith('965') && cleanPhone.length >= 11) ||
        (cleanPhone.length == 8 && RegExp(r'^[569]').hasMatch(cleanPhone));

    if (!isKuwaitPhone) {
      return false;
    }

    return true;
  }

  /// Checks whether user resides inside the specified country and has a local phone number.
  bool isInsideCountry(dynamic country) {
    final countryId = country is String ? country.toLowerCase() : (country?.id ?? 'kw').toString().toLowerCase();
    if (countryId == 'kw') return isInsideKuwait;

    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final residence = (countryOfResidence ?? '').trim().toLowerCase();

    if (countryId == 'sa') {
      if (residence.isNotEmpty &&
          !residence.contains('saudi') &&
          !residence.contains('سعودي') &&
          !residence.contains('ksa') &&
          !residence.contains('المملكة')) {
        return false;
      }
      final isSaudiPhone = cleanPhone.startsWith('+966') ||
          cleanPhone.startsWith('00966') ||
          (cleanPhone.startsWith('966') && cleanPhone.length >= 12) ||
          (cleanPhone.length == 9 && RegExp(r'^[5]').hasMatch(cleanPhone)) ||
          (cleanPhone.length == 10 && cleanPhone.startsWith('05'));
      return isSaudiPhone;
    }

    if (countryId == 'ae') {
      if (residence.isNotEmpty &&
          !residence.contains('uae') &&
          !residence.contains('emirates') &&
          !residence.contains('إمارات') &&
          !residence.contains('دبي') &&
          !residence.contains('dubai')) {
        return false;
      }
      final isUaePhone = cleanPhone.startsWith('+971') ||
          cleanPhone.startsWith('00971') ||
          (cleanPhone.startsWith('971') && cleanPhone.length >= 11) ||
          (cleanPhone.length == 9 && RegExp(r'^[5]').hasMatch(cleanPhone)) ||
          (cleanPhone.length == 10 && cleanPhone.startsWith('05'));
      return isUaePhone;
    }

    return isInsideKuwait;
  }
}

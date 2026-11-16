class ApplicantModel {
  final String id;
  final String name;
  final String profession;
  final String sector;
  final String subSector;
  final String nationality;
  final String governorate;
  final String experience;
  final int experienceYears;
  final int age;
  final String email;
  final String locationType; // 'inside' or 'outside'
  final String? photoUrl;
  final String? heroImage;
  final int views;
  final String phone;
  final String whatsapp;
  final bool isBookmarked;
  final String bio;
  final List<String> attachmentImages;
  final String resumeFileName;
  final String? resumePreviewImage;

  const ApplicantModel({
    required this.id,
    required this.name,
    required this.profession,
    required this.sector,
    required this.subSector,
    required this.nationality,
    required this.governorate,
    required this.experience,
    this.experienceYears = 5,
    this.age = 29,
    this.email = 'applicant@directwork.kw',
    required this.locationType,
    this.photoUrl,
    this.heroImage,
    this.views = 0,
    required this.phone,
    required this.whatsapp,
    this.isBookmarked = false,
    this.bio = 'Hard working, verified credentials, and quick to adapt to Kuwait site environments.',
    this.attachmentImages = const [],
    this.resumeFileName = 'Mohamed_Abass_Kamara_CV.pdf',
    this.resumePreviewImage,
  });

  ApplicantModel copyWith({
    String? id,
    String? name,
    String? profession,
    String? sector,
    String? subSector,
    String? nationality,
    String? governorate,
    String? experience,
    int? experienceYears,
    int? age,
    String? email,
    String? locationType,
    String? photoUrl,
    String? heroImage,
    int? views,
    String? phone,
    String? whatsapp,
    bool? isBookmarked,
    String? bio,
    List<String>? attachmentImages,
    String? resumeFileName,
    String? resumePreviewImage,
  }) {
    return ApplicantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profession: profession ?? this.profession,
      sector: sector ?? this.sector,
      subSector: subSector ?? this.subSector,
      nationality: nationality ?? this.nationality,
      governorate: governorate ?? this.governorate,
      experience: experience ?? this.experience,
      experienceYears: experienceYears ?? this.experienceYears,
      age: age ?? this.age,
      email: email ?? this.email,
      locationType: locationType ?? this.locationType,
      photoUrl: photoUrl ?? this.photoUrl,
      heroImage: heroImage ?? this.heroImage,
      views: views ?? this.views,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      bio: bio ?? this.bio,
      attachmentImages: attachmentImages ?? this.attachmentImages,
      resumeFileName: resumeFileName ?? this.resumeFileName,
      resumePreviewImage: resumePreviewImage ?? this.resumePreviewImage,
    );
  }

  factory ApplicantModel.fromJson(Map<String, dynamic> json) {
    return ApplicantModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      profession: json['profession']?.toString() ?? '',
      sector: json['sector']?.toString() ?? 'construction',
      subSector: json['sub_sector']?.toString() ?? 'All',
      nationality: json['nationality']?.toString() ?? 'Kuwait',
      governorate: json['governorate']?.toString() ?? 'All',
      experience: json['experience']?.toString() ?? '',
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 5,
      age: (json['age'] as num?)?.toInt() ?? 29,
      email: json['email']?.toString() ?? 'applicant@directwork.kw',
      locationType: json['location_type']?.toString() ?? 'inside',
      photoUrl: json['photo_url']?.toString(),
      heroImage: json['hero_image']?.toString(),
      views: (json['views'] as num?)?.toInt() ?? 0,
      phone: json['phone']?.toString() ?? '+965 6670 7126',
      whatsapp: json['whatsapp']?.toString() ?? '96566707126',
      isBookmarked: json['is_bookmarked'] == true,
      bio: json['bio']?.toString() ??
          'Hard working, verified credentials, and quick to adapt to Kuwait site environments.',
      attachmentImages: (json['attachment_images'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      resumeFileName: json['resume_file_name']?.toString() ??
          'Mohamed_Abass_Kamara_CV.pdf',
      resumePreviewImage: json['resume_preview_image']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profession': profession,
      'sector': sector,
      'sub_sector': subSector,
      'nationality': nationality,
      'governorate': governorate,
      'experience': experience,
      'experience_years': experienceYears,
      'age': age,
      'email': email,
      'location_type': locationType,
      'photo_url': photoUrl,
      'hero_image': heroImage,
      'views': views,
      'phone': phone,
      'whatsapp': whatsapp,
      'is_bookmarked': isBookmarked,
      'bio': bio,
      'attachment_images': attachmentImages,
      'resume_file_name': resumeFileName,
      'resume_preview_image': resumePreviewImage,
    };
  }

  /// Convenience getters for UI components
  String get contactPhone => phone.isNotEmpty ? phone : whatsapp;
  String get governorateName => governorate;
}

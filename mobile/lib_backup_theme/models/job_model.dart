class JobModel {
  final String id;
  final String title;
  final String companyName;
  final String? companyLogo;
  final String sectorCode;
  final String sectorName;
  final String professionName;
  final String governorateId;
  final String governorateName;
  final String workType; // full_time, part_time, freelance
  final String candidateCategory; // gcc_citizen, bedoun, resident, overseas
  final double? salaryKwd;
  final String description;
  final List<String> requirements;
  final String whatsappNumber;
  final String phoneNumber;
  final bool isPinned;
  final bool isFeatured;
  final int viewsCount;
  final DateTime createdAt;
  final bool isApplied;

  const JobModel({
    required this.id,
    required this.title,
    required this.companyName,
    this.companyLogo,
    required this.sectorCode,
    required this.sectorName,
    required this.professionName,
    required this.governorateId,
    required this.governorateName,
    required this.workType,
    required this.candidateCategory,
    this.salaryKwd,
    required this.description,
    required this.requirements,
    required this.whatsappNumber,
    required this.phoneNumber,
    this.isPinned = false,
    this.isFeatured = false,
    this.viewsCount = 0,
    required this.createdAt,
    this.isApplied = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      companyName: json['company_name'] ?? '',
      companyLogo: json['company_logo'],
      sectorCode: json['sector_code'] ?? '',
      sectorName: json['sector_name'] ?? '',
      professionName: json['profession_name'] ?? '',
      governorateId: json['governorate_id'] ?? 'capital',
      governorateName: json['governorate_name'] ?? 'محافظة العاصمة',
      workType: json['work_type'] ?? 'full_time',
      candidateCategory: json['candidate_category'] ?? 'all',
      salaryKwd: json['salary_kwd'] != null
          ? double.tryParse(json['salary_kwd'].toString())
          : null,
      description: json['description'] ?? '',
      requirements: json['requirements'] is List
          ? List<String>.from(json['requirements'])
          : (json['requirements'] != null
              ? [json['requirements'].toString()]
              : []),
      whatsappNumber: json['whatsapp_number'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      isPinned: json['is_pinned'] == true || json['is_pinned'] == 1,
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
      viewsCount: int.tryParse(json['views_count']?.toString() ?? '0') ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isApplied: json['is_applied'] == true || json['is_applied'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company_name': companyName,
      'company_logo': companyLogo,
      'sector_code': sectorCode,
      'sector_name': sectorName,
      'profession_name': professionName,
      'governorate_id': governorateId,
      'governorate_name': governorateName,
      'work_type': workType,
      'candidate_category': candidateCategory,
      'salary_kwd': salaryKwd,
      'description': description,
      'requirements': requirements,
      'whatsapp_number': whatsappNumber,
      'phone_number': phoneNumber,
      'is_pinned': isPinned,
      'is_featured': isFeatured,
      'views_count': viewsCount,
      'created_at': createdAt.toIso8601String(),
      'is_applied': isApplied,
    };
  }

  JobModel copyWith({
    bool? isApplied,
    int? viewsCount,
  }) {
    return JobModel(
      id: id,
      title: title,
      companyName: companyName,
      companyLogo: companyLogo,
      sectorCode: sectorCode,
      sectorName: sectorName,
      professionName: professionName,
      governorateId: governorateId,
      governorateName: governorateName,
      workType: workType,
      candidateCategory: candidateCategory,
      salaryKwd: salaryKwd,
      description: description,
      requirements: requirements,
      whatsappNumber: whatsappNumber,
      phoneNumber: phoneNumber,
      isPinned: isPinned,
      isFeatured: isFeatured,
      viewsCount: viewsCount ?? this.viewsCount,
      createdAt: createdAt,
      isApplied: isApplied ?? this.isApplied,
    );
  }
}

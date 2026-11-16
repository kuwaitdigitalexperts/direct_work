class JobApplicationModel {
  final String id;
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String governorateName;
  final String whatsappNumber;
  final String phoneNumber;
  final double? salaryKwd;
  final String applicantName;
  final String applicantPhone;
  final String? cvPath;
  final String? note;
  final String status; // 'submitted', 'under_review', 'shortlisted', 'rejected', 'active', 'expired'
  final DateTime appliedAt;
  final DateTime? expiresAt;
  final String? paymentId;
  final double? priceKwd;

  JobApplicationModel({
    required this.id,
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.governorateName,
    required this.whatsappNumber,
    required this.phoneNumber,
    this.salaryKwd,
    required this.applicantName,
    required this.applicantPhone,
    this.cvPath,
    this.note,
    this.status = 'active',
    required this.appliedAt,
    this.expiresAt,
    this.paymentId,
    this.priceKwd,
  });

  bool get isExpired {
    if (status == 'expired') return true;
    if (expiresAt != null && DateTime.now().isAfter(expiresAt!)) return true;
    return false;
  }

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    final applied = json['applied_at'] != null
        ? DateTime.tryParse(json['applied_at'])
        : (json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null);
    final appliedAtDate = applied ?? DateTime.now();
    final expires = json['expires_at'] != null
        ? DateTime.tryParse(json['expires_at'])
        : appliedAtDate.add(const Duration(days: 60)); // Default 2 months / 60 days

    return JobApplicationModel(
      id: json['id'] ?? 'app_${DateTime.now().millisecondsSinceEpoch}',
      jobId: json['job_id'] ?? '',
      jobTitle: json['job_title'] ?? 'وظيفة في الكويت',
      companyName: json['company_name'] ?? 'شركة كويتية',
      governorateName: json['governorate_name'] ?? 'محافظة العاصمة',
      whatsappNumber: json['whatsapp_number'] ?? '96599112233',
      phoneNumber: json['phone_number'] ?? '+965 22000000',
      salaryKwd: json['salary_kwd'] != null ? (json['salary_kwd'] as num).toDouble() : null,
      applicantName: json['name'] ?? json['applicant_name'] ?? '',
      applicantPhone: json['phone'] ?? json['applicant_phone'] ?? '',
      cvPath: json['cv_path'],
      note: json['note'],
      status: json['status'] ?? 'active',
      appliedAt: appliedAtDate,
      expiresAt: expires,
      paymentId: json['payment_id'],
      priceKwd: json['price_kwd'] != null ? (json['price_kwd'] as num).toDouble() : 2.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_id': jobId,
      'job_title': jobTitle,
      'company_name': companyName,
      'governorate_name': governorateName,
      'whatsapp_number': whatsappNumber,
      'phone_number': phoneNumber,
      'salary_kwd': salaryKwd,
      'name': applicantName,
      'phone': applicantPhone,
      'cv_path': cvPath,
      'note': note,
      'status': isExpired ? 'expired' : status,
      'created_at': appliedAt.toIso8601String(),
      'applied_at': appliedAt.toIso8601String(),
      'expires_at': (expiresAt ?? appliedAt.add(const Duration(days: 60))).toIso8601String(),
      'payment_id': paymentId,
      'price_kwd': priceKwd ?? 2.0,
    };
  }

  JobApplicationModel copyWith({
    String? id,
    String? jobId,
    String? jobTitle,
    String? companyName,
    String? governorateName,
    String? whatsappNumber,
    String? phoneNumber,
    double? salaryKwd,
    String? applicantName,
    String? applicantPhone,
    String? cvPath,
    String? note,
    String? status,
    DateTime? appliedAt,
    DateTime? expiresAt,
    String? paymentId,
    double? priceKwd,
  }) {
    return JobApplicationModel(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      governorateName: governorateName ?? this.governorateName,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      salaryKwd: salaryKwd ?? this.salaryKwd,
      applicantName: applicantName ?? this.applicantName,
      applicantPhone: applicantPhone ?? this.applicantPhone,
      cvPath: cvPath ?? this.cvPath,
      note: note ?? this.note,
      status: status ?? this.status,
      appliedAt: appliedAt ?? this.appliedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      paymentId: paymentId ?? this.paymentId,
      priceKwd: priceKwd ?? this.priceKwd,
    );
  }
}

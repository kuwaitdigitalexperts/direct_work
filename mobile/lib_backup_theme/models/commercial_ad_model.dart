class CommercialAdModel {
  final String id;
  final String title;
  final String businessName;
  final String? logoUrl;
  final String bannerImageUrl;
  final String description;
  final String? websiteUrl;
  final String phoneNumber;
  final String whatsappNumber;
  final String governorateName;
  final String categoryName;
  final bool isFeatured;
  final DateTime expiresAt;
  final DateTime createdAt;

  const CommercialAdModel({
    required this.id,
    required this.title,
    required this.businessName,
    this.logoUrl,
    required this.bannerImageUrl,
    required this.description,
    this.websiteUrl,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.governorateName,
    required this.categoryName,
    this.isFeatured = false,
    required this.expiresAt,
    required this.createdAt,
  });

  factory CommercialAdModel.fromJson(Map<String, dynamic> json) {
    return CommercialAdModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      businessName: json['business_name'] ?? '',
      logoUrl: json['logo_url'],
      bannerImageUrl: json['banner_image_url'] ?? '',
      description: json['description'] ?? '',
      websiteUrl: json['website_url'],
      phoneNumber: json['phone_number'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      governorateName: json['governorate_name'] ?? 'دولة الكويت',
      categoryName: json['category_name'] ?? 'عروض وخدمات تجارية',
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'].toString()) ??
              DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'business_name': businessName,
      'logo_url': logoUrl,
      'banner_image_url': bannerImageUrl,
      'description': description,
      'website_url': websiteUrl,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
      'governorate_name': governorateName,
      'category_name': categoryName,
      'is_featured': isFeatured,
      'expires_at': expiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

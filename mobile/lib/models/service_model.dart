class ServiceModel {
  final String id;
  final String title;
  final String categoryId;
  final String categoryName;
  final String subcategory;
  final String description;
  final double? priceKwd;
  final String providerName;
  final String? providerAvatar;
  final String phoneNumber;
  final String whatsappNumber;
  final String governorateName;
  final List<String> imageUrls;
  final double rating;
  final int reviewsCount;
  final DateTime createdAt;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.categoryName,
    required this.subcategory,
    required this.description,
    this.priceKwd,
    required this.providerName,
    this.providerAvatar,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.governorateName,
    required this.imageUrls,
    this.rating = 5.0,
    this.reviewsCount = 1,
    required this.createdAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      categoryId: json['category_id'] ?? '',
      categoryName: json['category_name'] ?? '',
      subcategory: json['subcategory'] ?? '',
      description: json['description'] ?? '',
      priceKwd: json['price_kwd'] != null
          ? double.tryParse(json['price_kwd'].toString())
          : null,
      providerName: json['provider_name'] ?? '',
      providerAvatar: json['provider_avatar'],
      phoneNumber: json['phone_number'] ?? '',
      whatsappNumber: json['whatsapp_number'] ?? '',
      governorateName: json['governorate_name'] ?? 'جميع محافظات الكويت',
      imageUrls: json['image_urls'] is List
          ? List<String>.from(json['image_urls'])
          : [],
      rating: double.tryParse(json['rating']?.toString() ?? '5.0') ?? 5.0,
      reviewsCount: int.tryParse(json['reviews_count']?.toString() ?? '1') ?? 1,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category_id': categoryId,
      'category_name': categoryName,
      'subcategory': subcategory,
      'description': description,
      'price_kwd': priceKwd,
      'provider_name': providerName,
      'provider_avatar': providerAvatar,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
      'governorate_name': governorateName,
      'image_urls': imageUrls,
      'rating': rating,
      'reviews_count': reviewsCount,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Convenience getters for UI components
  String get governorate => governorateName;
  String get contactPhone => phoneNumber.isNotEmpty ? phoneNumber : whatsappNumber;
}

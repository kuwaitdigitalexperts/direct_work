import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/commercial_ad_model.dart';

class CommercialService {
  final ApiClient _client = ApiClient();

  static List<CommercialAdModel> get defaultCommercialAds => const [];

  Future<List<CommercialAdModel>> getCommercialAds({String? search}) async {
    try {
      final response = await _client.dio.get(
        ApiEndpoints.commercialAds,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      if (response.data != null && response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((c) => CommercialAdModel.fromJson(Map<String, dynamic>.from(c)))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<bool> createCommercialAd(CommercialAdModel ad) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.createCommercialAd,
        data: ad.toJson(),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
}

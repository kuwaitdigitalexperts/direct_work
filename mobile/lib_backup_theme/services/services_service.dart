import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/service_model.dart';

class ServicesService {
  final ApiClient _client = ApiClient();

  static List<ServiceModel> get defaultServices => const [];

  Future<List<ServiceModel>> getServices({String? categoryId, String? search}) async {
    try {
      final response = await _client.dio.get(
        ApiEndpoints.services,
        queryParameters: {
          if (categoryId != null && categoryId.isNotEmpty) 'category_id': categoryId,
          if (search != null && search.isNotEmpty) 'search': search,
        },
      );
      if (response.data != null && response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((s) => ServiceModel.fromJson(Map<String, dynamic>.from(s)))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<bool> createService(ServiceModel service) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.createService,
        data: service.toJson(),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
}

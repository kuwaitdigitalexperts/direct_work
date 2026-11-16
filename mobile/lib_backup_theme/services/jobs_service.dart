import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/job_model.dart';

class JobsService {
  final ApiClient _client = ApiClient();

  static List<JobModel> get defaultJobs => const [];

  Future<List<JobModel>> getJobs({
    String? search,
    String? sectorCode,
    String? governorateId,
    String? workType,
    String? candidateCategory,
  }) async {
    try {
      final response = await _client.dio.get(
        ApiEndpoints.jobs,
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (sectorCode != null && sectorCode != 'all') 'sector': sectorCode,
          if (governorateId != null && governorateId != 'all') 'governorate': governorateId,
          if (workType != null && workType != 'all') 'work_type': workType,
          if (candidateCategory != null && candidateCategory != 'all') 'category': candidateCategory,
        },
      );
      if (response.data != null && response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((j) => JobModel.fromJson(Map<String, dynamic>.from(j)))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<JobModel?> getJobById(String id) async {
    try {
      final response = await _client.dio.get('${ApiEndpoints.jobDetails}/$id');
      if (response.data != null && response.data['data'] != null) {
        final data = response.data['data'];
        return JobModel.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (_) {}
    return null;
  }

  Future<bool> applyForJob({
    required String jobId,
    required String applicantName,
    required String phone,
    String? cvPath,
    String? note,
  }) async {
    try {
      final response = await _client.dio.post(
        '${ApiEndpoints.applyJob}/$jobId/apply',
        data: {
          'name': applicantName,
          'phone': phone,
          'cv_path': cvPath,
          'note': note,
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }

  Future<bool> createJob(JobModel job) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.jobs,
        data: job.toJson(),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      return false;
    }
  }
}

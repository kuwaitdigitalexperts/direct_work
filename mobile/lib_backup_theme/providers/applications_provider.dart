import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/job_application_model.dart';

class ApplicationsState {
  final List<JobApplicationModel> applications;
  final bool isLoading;
  final String? error;

  const ApplicationsState({
    this.applications = const [],
    this.isLoading = false,
    this.error,
  });

  ApplicationsState copyWith({
    List<JobApplicationModel>? applications,
    bool? isLoading,
    String? error,
  }) {
    return ApplicationsState(
      applications: applications ?? this.applications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ApplicationsNotifier extends StateNotifier<ApplicationsState> {
  final ApiClient _client = ApiClient();

  ApplicationsNotifier() : super(const ApplicationsState()) {
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _client.dio.get(ApiEndpoints.myApplications);
      if (response.data != null && response.data['data'] is List) {
        final list = (response.data['data'] as List)
            .map((item) => JobApplicationModel.fromJson(item))
            .toList();
        state = state.copyWith(applications: list, isLoading: false);
        return;
      }
      state = state.copyWith(isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void addApplication(JobApplicationModel app) {
    state = state.copyWith(
      applications: [app, ...state.applications.where((a) => a.jobId != app.jobId)],
    );
  }

  void withdrawApplication(String id) {
    state = state.copyWith(
      applications: state.applications.where((a) => a.id != id).toList(),
    );
  }
}

final applicationsProvider =
    StateNotifierProvider<ApplicationsNotifier, ApplicationsState>((ref) {
  return ApplicationsNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../services/jobs_service.dart';

class JobsFilterState {
  final String searchQuery;
  final String selectedSector;
  final String selectedGovernorate;
  final String selectedWorkType;
  final String selectedCandidateCategory;
  final List<JobModel> jobs;
  final bool isLoading;
  final String? error;

  const JobsFilterState({
    this.searchQuery = '',
    this.selectedSector = 'all',
    this.selectedGovernorate = 'all',
    this.selectedWorkType = 'all',
    this.selectedCandidateCategory = 'all',
    this.jobs = const [],
    this.isLoading = false,
    this.error,
  });

  JobsFilterState copyWith({
    String? searchQuery,
    String? selectedSector,
    String? selectedGovernorate,
    String? selectedWorkType,
    String? selectedCandidateCategory,
    List<JobModel>? jobs,
    bool? isLoading,
    String? error,
  }) {
    return JobsFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSector: selectedSector ?? this.selectedSector,
      selectedGovernorate: selectedGovernorate ?? this.selectedGovernorate,
      selectedWorkType: selectedWorkType ?? this.selectedWorkType,
      selectedCandidateCategory:
          selectedCandidateCategory ?? this.selectedCandidateCategory,
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class JobsNotifier extends StateNotifier<JobsFilterState> {
  final JobsService _service;

  JobsNotifier(this._service)
      : super(const JobsFilterState(jobs: [])) {
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final jobs = await _service.getJobs(
        search: state.searchQuery,
        sectorCode: state.selectedSector,
        governorateId: state.selectedGovernorate,
        workType: state.selectedWorkType,
        candidateCategory: state.selectedCandidateCategory,
      );
      state = state.copyWith(jobs: jobs, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'تعذر الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت والمحاولة مجدداً.',
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    fetchJobs();
  }

  void setSector(String sectorCode) {
    state = state.copyWith(selectedSector: sectorCode);
    fetchJobs();
  }

  void setGovernorate(String governorateId) {
    state = state.copyWith(selectedGovernorate: governorateId);
    fetchJobs();
  }

  void setWorkType(String workType) {
    state = state.copyWith(selectedWorkType: workType);
    fetchJobs();
  }

  void setCandidateCategory(String category) {
    state = state.copyWith(selectedCandidateCategory: category);
    fetchJobs();
  }

  void resetFilters() {
    state = state.copyWith(
      searchQuery: '',
      selectedSector: 'all',
      selectedGovernorate: 'all',
      selectedWorkType: 'all',
      selectedCandidateCategory: 'all',
    );
    fetchJobs();
  }

  Future<bool> apply(String jobId, String name, String phone, {String? cvPath, String? note}) async {
    final success = await _service.applyForJob(
      jobId: jobId,
      applicantName: name,
      phone: phone,
      cvPath: cvPath,
      note: note,
    );
    if (success) {
      final updated = state.jobs.map((j) {
        if (j.id == jobId) {
          return j.copyWith(isApplied: true);
        }
        return j;
      }).toList();
      state = state.copyWith(jobs: updated);
    }
    return success;
  }

  Future<bool> addJob(JobModel job) async {
    final success = await _service.createJob(job);
    if (success) {
      state = state.copyWith(jobs: [job, ...state.jobs]);
    }
    return success;
  }
}

final jobsServiceProvider = Provider<JobsService>((ref) => JobsService());

final jobsProvider = StateNotifierProvider<JobsNotifier, JobsFilterState>((ref) {
  return JobsNotifier(ref.watch(jobsServiceProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/applicant_model.dart';
import '../services/applicants_service.dart';

final applicantsServiceProvider = Provider<ApplicantsService>((ref) {
  return ApplicantsService();
});

class ApplicantsState {
  final List<ApplicantModel> applicants;
  final bool isLoading;
  final String selectedSector;
  final String selectedSubSector;
  final String selectedProfession;
  final String selectedGovernorate;
  final String locationType;
  final String searchQuery;

  const ApplicantsState({
    this.applicants = const [],
    this.isLoading = false,
    this.selectedSector = 'construction',
    this.selectedSubSector = 'All',
    this.selectedProfession = 'All professions',
    this.selectedGovernorate = 'All Governorates',
    this.locationType = 'inside',
    this.searchQuery = '',
  });

  ApplicantsState copyWith({
    List<ApplicantModel>? applicants,
    bool? isLoading,
    String? selectedSector,
    String? selectedSubSector,
    String? selectedProfession,
    String? selectedGovernorate,
    String? locationType,
    String? searchQuery,
  }) {
    return ApplicantsState(
      applicants: applicants ?? this.applicants,
      isLoading: isLoading ?? this.isLoading,
      selectedSector: selectedSector ?? this.selectedSector,
      selectedSubSector: selectedSubSector ?? this.selectedSubSector,
      selectedProfession: selectedProfession ?? this.selectedProfession,
      selectedGovernorate: selectedGovernorate ?? this.selectedGovernorate,
      locationType: locationType ?? this.locationType,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ApplicantsNotifier extends StateNotifier<ApplicantsState> {
  final ApplicantsService _service;

  ApplicantsNotifier(this._service) : super(const ApplicantsState()) {
    fetchApplicants();
  }

  Future<void> initSector({
    required String sector,
    required String locationType,
  }) async {
    state = state.copyWith(
      selectedSector: sector,
      locationType: locationType,
      selectedSubSector: 'All',
      selectedProfession: 'All professions',
      selectedGovernorate: 'All Governorates',
      searchQuery: '',
    );
    await fetchApplicants();
  }

  Future<void> fetchApplicants() async {
    state = state.copyWith(isLoading: true);
    final results = await _service.getApplicants(
      sector: state.selectedSector,
      subSector: state.selectedSubSector,
      profession: state.selectedProfession,
      governorate: state.selectedGovernorate,
      locationType: state.locationType,
      search: state.searchQuery,
    );
    state = state.copyWith(applicants: results, isLoading: false);
  }

  Future<void> setSubSector(String subSector) async {
    state = state.copyWith(selectedSubSector: subSector);
    await fetchApplicants();
  }

  Future<void> setProfession(String profession) async {
    state = state.copyWith(selectedProfession: profession);
    await fetchApplicants();
  }

  Future<void> setGovernorate(String governorate) async {
    state = state.copyWith(selectedGovernorate: governorate);
    await fetchApplicants();
  }

  Future<void> setSearch(String query) async {
    state = state.copyWith(searchQuery: query);
    await fetchApplicants();
  }

  void toggleBookmark(String id) {
    state = state.copyWith(
      applicants: state.applicants.map((a) {
        if (a.id == id) {
          return a.copyWith(isBookmarked: !a.isBookmarked);
        }
        return a;
      }).toList(),
    );
  }
}

final applicantsProvider = StateNotifierProvider<ApplicantsNotifier, ApplicantsState>((ref) {
  final service = ref.watch(applicantsServiceProvider);
  return ApplicantsNotifier(service);
});

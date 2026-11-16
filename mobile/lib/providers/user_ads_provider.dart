import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../models/service_model.dart';
import '../models/commercial_ad_model.dart';
import 'jobs_provider.dart';

class UserAdsState {
  final List<JobModel> myJobs;
  final List<ServiceModel> myServices;
  final List<CommercialAdModel> myCommercialAds;
  final bool isLoading;

  const UserAdsState({
    this.myJobs = const [],
    this.myServices = const [],
    this.myCommercialAds = const [],
    this.isLoading = false,
  });

  UserAdsState copyWith({
    List<JobModel>? myJobs,
    List<ServiceModel>? myServices,
    List<CommercialAdModel>? myCommercialAds,
    bool? isLoading,
  }) {
    return UserAdsState(
      myJobs: myJobs ?? this.myJobs,
      myServices: myServices ?? this.myServices,
      myCommercialAds: myCommercialAds ?? this.myCommercialAds,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserAdsNotifier extends StateNotifier<UserAdsState> {
  final Ref _ref;

  UserAdsNotifier(this._ref) : super(const UserAdsState());

  void addJob(JobModel job) {
    state = state.copyWith(myJobs: [job, ...state.myJobs]);
    // Also inject into global jobs feed
    final currentJobs = _ref.read(jobsProvider).jobs;
    _ref.read(jobsProvider.notifier).state =
        _ref.read(jobsProvider).copyWith(jobs: [job, ...currentJobs]);
  }

  void addService(ServiceModel service) {
    state = state.copyWith(myServices: [service, ...state.myServices]);
  }

  void addCommercialAd(CommercialAdModel ad) {
    state = state.copyWith(myCommercialAds: [ad, ...state.myCommercialAds]);
  }

  void deleteJob(String id) {
    state = state.copyWith(
      myJobs: state.myJobs.where((j) => j.id != id).toList(),
    );
  }

  void deleteService(String id) {
    state = state.copyWith(
      myServices: state.myServices.where((s) => s.id != id).toList(),
    );
  }

  void deleteCommercialAd(String id) {
    state = state.copyWith(
      myCommercialAds: state.myCommercialAds.where((a) => a.id != id).toList(),
    );
  }
}

final userAdsProvider =
    StateNotifierProvider<UserAdsNotifier, UserAdsState>((ref) {
  return UserAdsNotifier(ref);
});

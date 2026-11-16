import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/commercial_ad_model.dart';
import '../services/commercial_service.dart';

class CommercialState {
  final List<CommercialAdModel> ads;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const CommercialState({
    this.ads = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  CommercialState copyWith({
    List<CommercialAdModel>? ads,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return CommercialState(
      ads: ads ?? this.ads,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CommercialNotifier extends StateNotifier<CommercialState> {
  final CommercialService _service;

  CommercialNotifier(this._service)
      : super(const CommercialState(ads: [])) {
    fetchAds();
  }

  Future<void> fetchAds() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final list = await _service.getCommercialAds(search: state.searchQuery);
      state = state.copyWith(ads: list, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'تعذر تحميل الإعلانات');
    }
  }

  void setSearch(String query) {
    state = state.copyWith(searchQuery: query);
    fetchAds();
  }

  Future<bool> addCommercialAd(CommercialAdModel ad) async {
    final ok = await _service.createCommercialAd(ad);
    if (ok) {
      await fetchAds();
    }
    return ok;
  }
}

final commercialServiceProvider = Provider<CommercialService>((ref) => CommercialService());

final commercialProvider = StateNotifierProvider<CommercialNotifier, CommercialState>((ref) {
  return CommercialNotifier(ref.watch(commercialServiceProvider));
});

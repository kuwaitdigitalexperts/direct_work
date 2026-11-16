import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_model.dart';
import '../services/services_service.dart';

class ServicesState {
  final List<ServiceModel> services;
  final String selectedCategory;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const ServicesState({
    this.services = const [],
    this.selectedCategory = '',
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  ServicesState copyWith({
    List<ServiceModel>? services,
    String? selectedCategory,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return ServicesState(
      services: services ?? this.services,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ServicesNotifier extends StateNotifier<ServicesState> {
  final ServicesService _service;

  ServicesNotifier(this._service)
      : super(const ServicesState(services: [])) {
    fetchServices();
  }

  Future<void> fetchServices() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final list = await _service.getServices(
        categoryId: state.selectedCategory,
        search: state.searchQuery,
      );
      state = state.copyWith(services: list, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'تعذر تحميل الخدمات');
    }
  }

  void setCategory(String catId) {
    state = state.copyWith(selectedCategory: catId == state.selectedCategory ? '' : catId);
    fetchServices();
  }

  void setSearch(String query) {
    state = state.copyWith(searchQuery: query);
    fetchServices();
  }

  Future<bool> addService(ServiceModel srv) async {
    final ok = await _service.createService(srv);
    if (ok) {
      await fetchServices();
    }
    return ok;
  }

  void deleteService(String id) {
    state = state.copyWith(
      services: state.services.where((s) => s.id != id).toList(),
    );
  }
}

final servicesServiceProvider = Provider<ServicesService>((ref) => ServicesService());

final servicesProvider = StateNotifierProvider<ServicesNotifier, ServicesState>((ref) {
  return ServicesNotifier(ref.watch(servicesServiceProvider));
});

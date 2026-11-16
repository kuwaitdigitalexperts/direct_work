import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';

class PricingTier {
  final String title;
  final int durationMonths;
  final String durationText;
  final double priceKwd;
  final String priceText;
  final bool isFree;

  const PricingTier({
    required this.title,
    required this.durationMonths,
    required this.durationText,
    required this.priceKwd,
    required this.priceText,
    required this.isFree,
  });

  factory PricingTier.fromJson(Map<String, dynamic> json, {required bool defaultIsInside}) {
    final months = json['duration_months'] != null
        ? (json['duration_months'] as num).toInt()
        : 3;
    final price = json['price_kwd'] != null
        ? (json['price_kwd'] as num).toDouble()
        : 2.0;
    final free = json['is_free'] ?? (price == 0.0);

    return PricingTier(
      title: json['title'] ?? (defaultIsInside ? 'Inside Kuwait Application' : 'Outside Kuwait Application'),
      durationMonths: months,
      durationText: json['duration_text'] ?? '$months months',
      priceKwd: price,
      priceText: json['price_text'] ?? (free ? 'Free' : '${price.toInt()} KWD'),
      isFree: free,
    );
  }
}

class ApplicationPricingState {
  final PricingTier insideTier;
  final PricingTier outsideTier;
  final bool isLoading;

  const ApplicationPricingState({
    this.insideTier = const PricingTier(
      title: 'Inside Kuwait Application',
      durationMonths: 3,
      durationText: '3 months',
      priceKwd: 2.0,
      priceText: '2 KWD',
      isFree: false,
    ),
    this.outsideTier = const PricingTier(
      title: 'Outside Kuwait Application',
      durationMonths: 3, // 3 months
      durationText: '3 months',
      priceKwd: 2.0,     // 2 KWD
      priceText: '2 KWD',
      isFree: false,
    ),
    this.isLoading = false,
  });

  ApplicationPricingState copyWith({
    PricingTier? insideTier,
    PricingTier? outsideTier,
    bool? isLoading,
  }) {
    return ApplicationPricingState(
      insideTier: insideTier ?? this.insideTier,
      outsideTier: outsideTier ?? this.outsideTier,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ApplicationPricingNotifier extends StateNotifier<ApplicationPricingState> {
  final ApiClient _client = ApiClient();

  ApplicationPricingNotifier() : super(const ApplicationPricingState()) {
    fetchPricing();
  }

  Future<void> fetchPricing() async {
    try {
      final response = await _client.dio.get(ApiEndpoints.applicationPricing);
      if (response.data != null && response.data is Map) {
        final data = Map<String, dynamic>.from(response.data);
        final inside = data['inside'] != null
            ? PricingTier.fromJson(Map<String, dynamic>.from(data['inside']), defaultIsInside: true)
            : state.insideTier;
        final outside = data['outside'] != null
            ? PricingTier.fromJson(Map<String, dynamic>.from(data['outside']), defaultIsInside: false)
            : state.outsideTier;
        state = state.copyWith(insideTier: inside, outsideTier: outside, isLoading: false);
      }
    } catch (_) {
      // Graceful fallback to state defaults
    }
  }
}

final applicationPricingProvider =
    StateNotifierProvider<ApplicationPricingNotifier, ApplicationPricingState>((ref) {
  return ApplicationPricingNotifier();
});

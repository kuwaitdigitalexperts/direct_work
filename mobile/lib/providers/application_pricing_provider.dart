import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/country_config.dart';
import 'country_provider.dart';

class PricingTier {
  final String title;
  final int durationMonths;
  final String durationText;
  final double price;
  final String currency;
  final String currencyAr;
  final String priceText;
  final bool isFree;

  const PricingTier({
    required this.title,
    required this.durationMonths,
    required this.durationText,
    required this.price,
    required this.currency,
    required this.currencyAr,
    required this.priceText,
    required this.isFree,
  });

  double get priceKwd => price;

  factory PricingTier.forCountry(CountryConfig country, {required bool defaultIsInside}) {
    double p;
    String currEn;
    String currAr;

    switch (country.id.toLowerCase()) {
      case 'sa':
        p = 35.0;
        currEn = 'SAR';
        currAr = 'ر.س';
        break;
      case 'ae':
        p = 30.0;
        currEn = 'AED';
        currAr = 'د.إ';
        break;
      case 'kw':
      default:
        p = 2.0;
        currEn = 'KWD';
        currAr = 'د.ك';
        break;
    }

    final pFormatted = p % 1 == 0 ? p.toInt().toString() : p.toStringAsFixed(1);
    final title = defaultIsInside
        ? 'Inside ${country.shortNameEn} Application'
        : 'Outside ${country.shortNameEn} Application';

    return PricingTier(
      title: title,
      durationMonths: 3,
      durationText: '3 months',
      price: p,
      currency: currEn,
      currencyAr: currAr,
      priceText: '$pFormatted $currEn',
      isFree: false,
    );
  }

  factory PricingTier.fromJson(Map<String, dynamic> json, CountryConfig country, {required bool defaultIsInside}) {
    final base = PricingTier.forCountry(country, defaultIsInside: defaultIsInside);
    final months = json['duration_months'] != null
        ? (json['duration_months'] as num).toInt()
        : base.durationMonths;
    final price = json['price'] != null
        ? (json['price'] as num).toDouble()
        : (json['price_kwd'] != null ? (json['price_kwd'] as num).toDouble() : base.price);
    final free = json['is_free'] ?? (price == 0.0);

    return PricingTier(
      title: json['title'] ?? base.title,
      durationMonths: months,
      durationText: json['duration_text'] ?? '$months months',
      price: price,
      currency: json['currency'] ?? base.currency,
      currencyAr: json['currency_ar'] ?? base.currencyAr,
      priceText: json['price_text'] ?? (free ? 'Free' : '${price.toInt()} ${base.currency}'),
      isFree: free,
    );
  }
}

class ApplicationPricingState {
  final PricingTier insideTier;
  final PricingTier outsideTier;
  final bool isLoading;
  final CountryConfig country;

  ApplicationPricingState({
    required this.country,
    PricingTier? insideTier,
    PricingTier? outsideTier,
    this.isLoading = false,
  })  : insideTier = insideTier ?? PricingTier.forCountry(country, defaultIsInside: true),
        outsideTier = outsideTier ?? PricingTier.forCountry(country, defaultIsInside: false);

  ApplicationPricingState copyWith({
    PricingTier? insideTier,
    PricingTier? outsideTier,
    bool? isLoading,
    CountryConfig? country,
  }) {
    final c = country ?? this.country;
    return ApplicationPricingState(
      country: c,
      insideTier: insideTier ?? this.insideTier,
      outsideTier: outsideTier ?? this.outsideTier,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ApplicationPricingNotifier extends StateNotifier<ApplicationPricingState> {
  final ApiClient _client = ApiClient();
  final CountryConfig _country;

  ApplicationPricingNotifier(this._country)
      : super(ApplicationPricingState(country: _country)) {
    fetchPricing();
  }

  Future<void> fetchPricing() async {
    try {
      final response = await _client.dio.get(
        ApiEndpoints.applicationPricing,
        queryParameters: {'country': _country.id},
      );
      if (response.data != null && response.data is Map) {
        final data = Map<String, dynamic>.from(response.data);
        final inside = data['inside'] != null
            ? PricingTier.fromJson(Map<String, dynamic>.from(data['inside']), _country, defaultIsInside: true)
            : state.insideTier;
        final outside = data['outside'] != null
            ? PricingTier.fromJson(Map<String, dynamic>.from(data['outside']), _country, defaultIsInside: false)
            : state.outsideTier;
        state = state.copyWith(insideTier: inside, outsideTier: outside, isLoading: false);
      }
    } catch (_) {
      // Graceful fallback to country defaults
    }
  }
}

final applicationPricingProvider =
    StateNotifierProvider<ApplicationPricingNotifier, ApplicationPricingState>((ref) {
  final country = ref.watch(countryProvider);
  return ApplicationPricingNotifier(country);
});

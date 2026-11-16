import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/countries_data.dart';
import '../core/utils/app_preferences.dart';
import '../models/country_config.dart';

export '../models/country_config.dart';

class CountryNotifier extends StateNotifier<CountryConfig> {
  static const String prefKey = 'direct_job_selected_country';

  CountryNotifier() : super(CountriesData.kuwait) {
    _loadCountry();
  }

  Future<void> _loadCountry() async {
    try {
      final code = await AppPreferences.getString(prefKey);
      if (code != null && code.isNotEmpty) {
        state = CountriesData.getById(code);
      }
    } catch (_) {
      state = CountriesData.kuwait;
    }
  }

  Future<void> setCountry(CountryConfig country) async {
    state = country;
    try {
      await AppPreferences.setString(prefKey, country.id);
    } catch (_) {}
  }

  Future<void> setCountryById(String id) async {
    final country = CountriesData.getById(id);
    await setCountry(country);
  }
}

final countryProvider = StateNotifierProvider<CountryNotifier, CountryConfig>((ref) {
  return CountryNotifier();
});

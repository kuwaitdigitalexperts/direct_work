import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/localization/language_model.dart';
import '../core/utils/app_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  static const String prefKey = 'direct_job_selected_locale';

  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      final code = await AppPreferences.getString(prefKey);
      if (code != null && AppLanguage.supportedCodes.contains(code)) {
        state = Locale(code);
      }
    } catch (_) {
      // Default to English on any error
      state = const Locale('en');
    }
  }

  Future<void> setLocale(Locale locale) async {
    final code = locale.languageCode;
    if (AppLanguage.supportedCodes.contains(code)) {
      state = locale;
      try {
        await AppPreferences.setString(prefKey, code);
      } catch (_) {}
    }
  }

  Future<void> setLanguageCode(String code) async {
    await setLocale(Locale(code));
  }

  void toggleLocale() {
    if (state.languageCode == 'ar') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('ar'));
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

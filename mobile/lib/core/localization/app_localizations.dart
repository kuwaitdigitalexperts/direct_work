import 'package:flutter/material.dart';
import 'language_model.dart';
import 'languages/ar.dart';
import 'languages/bn.dart';
import 'languages/en.dart';
import 'languages/hi.dart';
import 'languages/ml.dart';
import 'languages/ta.dart';
import 'languages/te.dart';
import 'languages/tl.dart';
import 'languages/ur.dart';

export 'language_model.dart';

class AppLocalizations {
  final Locale locale;

  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('en'));
  }

  bool get isArabic => locale.languageCode == 'ar';
  bool get isRtl => locale.languageCode == 'ar' || locale.languageCode == 'ur';
  TextDirection get textDirection => isRtl ? TextDirection.rtl : TextDirection.ltr;
  AppLanguage get currentLanguage => AppLanguage.getLanguage(locale.languageCode);

  static const Map<String, Map<String, String>> _allTranslations = {
    'ar': arTranslations,
    'en': enTranslations,
    'ur': urTranslations,
    'hi': hiTranslations,
    'bn': bnTranslations,
    'tl': tlTranslations,
    'fil': tlTranslations,
    'ml': mlTranslations,
    'te': teTranslations,
    'ta': taTranslations,
  };

  String translate(String key) {
    final code = locale.languageCode == 'fil' ? 'tl' : locale.languageCode;
    return _allTranslations[code]?[key] ??
        _allTranslations['en']?[key] ??
        _allTranslations['ar']?[key] ??
        key;
  }

  String operator [](String key) => translate(key);

  static bool hasKey(String key) {
    return enTranslations.containsKey(key);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLanguage.supportedCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

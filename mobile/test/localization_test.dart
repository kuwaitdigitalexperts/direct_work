import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';

void main() {
  group('AppLocalizations 9-Language Tests', () {
    final supportedCodes = ['ar', 'en', 'ur', 'hi', 'bn', 'tl', 'ml', 'te', 'ta'];

    test('Delegate supports all 9 target languages', () {
      const delegate = AppLocalizationsDelegate();
      for (final code in supportedCodes) {
        expect(delegate.isSupported(Locale(code)), isTrue, reason: 'Delegate should support $code');
      }
      expect(delegate.isSupported(const Locale('fil')), isTrue);
      expect(delegate.isSupported(const Locale('fr')), isFalse);
    });

    test('Directionality and RTL detection is correct', () {
      final arL10n = AppLocalizations(const Locale('ar'));
      final urL10n = AppLocalizations(const Locale('ur'));
      final enL10n = AppLocalizations(const Locale('en'));
      final hiL10n = AppLocalizations(const Locale('hi'));
      final bnL10n = AppLocalizations(const Locale('bn'));
      final tlL10n = AppLocalizations(const Locale('tl'));
      final mlL10n = AppLocalizations(const Locale('ml'));
      final teL10n = AppLocalizations(const Locale('te'));
      final taL10n = AppLocalizations(const Locale('ta'));

      expect(arL10n.isRtl, isTrue);
      expect(urL10n.isRtl, isTrue);
      expect(enL10n.isRtl, isFalse);
      expect(hiL10n.isRtl, isFalse);
      expect(bnL10n.isRtl, isFalse);
      expect(tlL10n.isRtl, isFalse);
      expect(mlL10n.isRtl, isFalse);
      expect(teL10n.isRtl, isFalse);
      expect(taL10n.isRtl, isFalse);

      expect(arL10n.textDirection, TextDirection.rtl);
      expect(urL10n.textDirection, TextDirection.rtl);
      expect(enL10n.textDirection, TextDirection.ltr);
    });

    test('All 9 language dictionaries contain valid translations for core keys', () {
      final criticalKeys = [
        'app_name',
        'app_tagline',
        'tab_home',
        'tab_search',
        'tab_jobs',
        'tab_services',
        'tab_commercial',
        'tab_chats',
        'tab_profile',
        'direct_work_title',
        'direct_work_tagline',
        'post_ad_btn',
        'search_jobs_hint',
        'all_sectors',
        'latest_jobs',
        'jobs_available',
        'no_jobs_found',
        'apply_now',
        'direct_apply',
        'contact_whatsapp',
        'call_phone',
        'login',
        'register',
        'full_name',
        'phone',
        'select_language',
        'employer_mode',
        'seeker_mode',
      ];

      for (final code in supportedCodes) {
        final l10n = AppLocalizations(Locale(code));
        for (final key in criticalKeys) {
          final translated = l10n.translate(key);
          expect(translated, isNotEmpty, reason: '$code translation for $key is empty');
          expect(translated, isNot(equals(key)), reason: '$code fell back to key for $key');
        }
      }
    });

    test('Native names and flags are properly configured in AppLanguage model', () {
      expect(AppLanguage.supportedLanguages.length, equals(9));

      final ar = AppLanguage.getLanguage('ar');
      expect(ar.nativeName, equals('العربية'));
      expect(ar.flag, equals('🇰🇼'));
      expect(ar.isRtl, isTrue);

      final ur = AppLanguage.getLanguage('ur');
      expect(ur.nativeName, equals('اردو'));
      expect(ur.flag, equals('🇵🇰'));
      expect(ur.isRtl, isTrue);

      final hi = AppLanguage.getLanguage('hi');
      expect(hi.nativeName, equals('हिन्दी'));
      expect(hi.flag, equals('🇮🇳'));

      final bn = AppLanguage.getLanguage('bn');
      expect(bn.nativeName, equals('বাংলা'));
      expect(bn.flag, equals('🇧🇩'));

      final tl = AppLanguage.getLanguage('tl');
      expect(tl.nativeName, equals('Tagalog'));
      expect(tl.flag, equals('🇵🇭'));

      final ml = AppLanguage.getLanguage('ml');
      expect(ml.nativeName, equals('മലയാളം'));

      final te = AppLanguage.getLanguage('te');
      expect(te.nativeName, equals('తెలుగు'));

      final ta = AppLanguage.getLanguage('ta');
      expect(ta.nativeName, equals('தமிழ்'));
    });

    test('Safe fallback returns English or Arabic or key when missing', () {
      final l10n = AppLocalizations(const Locale('en'));
      expect(l10n.translate('non_existent_key_12345'), equals('non_existent_key_12345'));
    });
  });
}

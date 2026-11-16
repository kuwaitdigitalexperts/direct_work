class AppLanguage {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final bool isRtl;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    this.isRtl = false,
  });

  static const List<AppLanguage> supportedLanguages = [
    AppLanguage(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇰🇼',
      isRtl: true,
    ),
    AppLanguage(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇬🇧',
      isRtl: false,
    ),
    AppLanguage(
      code: 'ur',
      name: 'Urdu',
      nativeName: 'اردو',
      flag: '🇵🇰',
      isRtl: true,
    ),
    AppLanguage(
      code: 'hi',
      name: 'Hindi',
      nativeName: 'हिन्दी',
      flag: '🇮🇳',
      isRtl: false,
    ),
    AppLanguage(
      code: 'bn',
      name: 'Bengali',
      nativeName: 'বাংলা',
      flag: '🇧🇩',
      isRtl: false,
    ),
    AppLanguage(
      code: 'tl',
      name: 'Filipino (Tagalog)',
      nativeName: 'Tagalog',
      flag: '🇵🇭',
      isRtl: false,
    ),
    AppLanguage(
      code: 'ml',
      name: 'Malayalam',
      nativeName: 'മലയാളം',
      flag: '🇮🇳',
      isRtl: false,
    ),
    AppLanguage(
      code: 'te',
      name: 'Telugu',
      nativeName: 'తెలుగు',
      flag: '🇮🇳',
      isRtl: false,
    ),
    AppLanguage(
      code: 'ta',
      name: 'Tamil',
      nativeName: 'தமிழ்',
      flag: '🇮🇳',
      isRtl: false,
    ),
  ];

  static const List<String> supportedCodes = [
    'ar',
    'en',
    'ur',
    'hi',
    'bn',
    'tl',
    'fil',
    'ml',
    'te',
    'ta',
  ];

  static AppLanguage getLanguage(String code) {
    final normalized = code == 'fil' ? 'tl' : code;
    return supportedLanguages.firstWhere(
      (lang) => lang.code == normalized,
      orElse: () => supportedLanguages.firstWhere((l) => l.code == 'en'),
    );
  }
}

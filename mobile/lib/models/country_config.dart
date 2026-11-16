class CountryConfig {
  final String id;
  final String nameAr;
  final String nameEn;
  final String shortNameAr;
  final String shortNameEn;
  final String flagEmoji;
  final String phoneCode;
  final String currencyAr;
  final String currencyEn;
  final String descriptionAr;
  final String descriptionEn;
  final List<Map<String, String>> regions;
  final List<Map<String, String>> nationalities;
  final List<Map<String, dynamic>> sectors;

  List<Map<String, String>> get governorates => regions;

  const CountryConfig({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.shortNameAr,
    required this.shortNameEn,
    required this.flagEmoji,
    required this.phoneCode,
    required this.currencyAr,
    required this.currencyEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.regions,
    required this.nationalities,
    required this.sectors,
  });

  String localizedName(String langCode) {
    return langCode == 'ar' ? nameAr : nameEn;
  }

  String localizedShortName(String langCode) {
    return langCode == 'ar' ? shortNameAr : shortNameEn;
  }

  String localizedCurrency(String langCode) {
    return langCode == 'ar' ? currencyAr : currencyEn;
  }

  String localizedDescription(String langCode) {
    return langCode == 'ar' ? descriptionAr : descriptionEn;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryConfig &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

import '../../models/country_config.dart';
import 'kuwait_data.dart';

class CountriesData {
  // Kuwait
  static final CountryConfig kuwait = CountryConfig(
    id: 'kw',
    nameAr: KuwaitData.countryNameAr,
    nameEn: KuwaitData.countryNameEn,
    shortNameAr: 'الكويت',
    shortNameEn: 'Kuwait',
    flagEmoji: '🇰🇼',
    phoneCode: '+965',
    currencyAr: KuwaitData.currencyAr,
    currencyEn: KuwaitData.currencyEn,
    descriptionAr: 'السوق المعتمد (6 محافظات كويتية)',
    descriptionEn: 'Kuwait Market (6 Governorates)',
    regions: KuwaitData.governorates,
    nationalities: KuwaitData.nationalities,
    sectors: KuwaitData.jobSeekerSectors,
  );

  // Saudi Arabia
  static const List<Map<String, String>> saudiRegions = [
    {'id': 'riyadh', 'name_ar': 'منطقة الرياض', 'name_en': 'Riyadh Region'},
    {'id': 'makkah', 'name_ar': 'منطقة مكة المكرمة (جدة والطائف)', 'name_en': 'Makkah Region (Jeddah & Taif)'},
    {'id': 'eastern', 'name_ar': 'المنطقة الشرقية (الدمام والخبر)', 'name_en': 'Eastern Province (Dammam & Khobar)'},
    {'id': 'madinah', 'name_ar': 'منطقة المدينة المنورة', 'name_en': 'Madinah Region'},
    {'id': 'qassim', 'name_ar': 'منطقة القصيم (بريدة وعنيزة)', 'name_en': 'Al-Qassim Region'},
    {'id': 'asir', 'name_ar': 'منطقة عسير (أبها وخميس مشيط)', 'name_en': 'Asir Region (Abha)'},
    {'id': 'tabuk', 'name_ar': 'منطقة تبوك', 'name_en': 'Tabuk Region'},
    {'id': 'hail', 'name_ar': 'منطقة حائل', 'name_en': 'Hail Region'},
    {'id': 'jazan', 'name_ar': 'منطقة جازان', 'name_en': 'Jazan Region'},
    {'id': 'najran', 'name_ar': 'منطقة نجران', 'name_en': 'Najran Region'},
    {'id': 'baha', 'name_ar': 'منطقة الباحة', 'name_en': 'Al-Baha Region'},
    {'id': 'jouf', 'name_ar': 'منطقة الجوف (سكاكا)', 'name_en': 'Al-Jouf Region'},
    {'id': 'northern', 'name_ar': 'منطقة الحدود الشمالية (عرعر)', 'name_en': 'Northern Borders Region'},
  ];

  static const List<Map<String, String>> saudiNationalities = [
    {'id': 'sa', 'name_ar': 'سعودي', 'name_en': 'Saudi'},
    {'id': 'eg', 'name_ar': 'مصري', 'name_en': 'Egyptian'},
    {'id': 'ye', 'name_ar': 'يمني', 'name_en': 'Yemeni'},
    {'id': 'in', 'name_ar': 'هندي', 'name_en': 'Indian'},
    {'id': 'pk', 'name_ar': 'باكستاني', 'name_en': 'Pakistani'},
    {'id': 'bd', 'name_ar': 'بنغلاديشي', 'name_en': 'Bangladeshi'},
    {'id': 'ph', 'name_ar': 'فلبيني', 'name_en': 'Filipino'},
    {'id': 'sd', 'name_ar': 'سوداني', 'name_en': 'Sudanese'},
    {'id': 'sy', 'name_ar': 'سوري', 'name_en': 'Syrian'},
    {'id': 'jo', 'name_ar': 'أردني', 'name_en': 'Jordanian'},
    {'id': 'lb', 'name_ar': 'لبناني', 'name_en': 'Lebanese'},
    {'id': 'np', 'name_ar': 'نيبالي', 'name_en': 'Nepali'},
    {'id': 'lk', 'name_ar': 'سريلانكي', 'name_en': 'Sri Lankan'},
    {'id': 'other', 'name_ar': 'أخرى', 'name_en': 'Other'},
  ];

  static final CountryConfig saudi = CountryConfig(
    id: 'sa',
    nameAr: 'المملكة العربية السعودية',
    nameEn: 'Kingdom of Saudi Arabia',
    shortNameAr: 'السعودية',
    shortNameEn: 'Saudi Arabia',
    flagEmoji: '🇸🇦',
    phoneCode: '+966',
    currencyAr: 'ر.س',
    currencyEn: 'SAR',
    descriptionAr: 'سوق المملكة (13 منطقة إدارية)',
    descriptionEn: 'Saudi Market (13 Regions)',
    regions: saudiRegions,
    nationalities: saudiNationalities,
    sectors: KuwaitData.jobSeekerSectors,
  );

  // UAE (Dubai)
  static const List<Map<String, String>> uaeEmirates = [
    {'id': 'dubai', 'name_ar': 'إمارة دبي', 'name_en': 'Dubai'},
    {'id': 'abudhabi', 'name_ar': 'إمارة أبوظبي', 'name_en': 'Abu Dhabi'},
    {'id': 'sharjah', 'name_ar': 'إمارة الشارقة', 'name_en': 'Sharjah'},
    {'id': 'ajman', 'name_ar': 'إمارة عجمان', 'name_en': 'Ajman'},
    {'id': 'rak', 'name_ar': 'إمارة رأس الخيمة', 'name_en': 'Ras Al Khaimah'},
    {'id': 'fujairah', 'name_ar': 'إمارة الفجيرة', 'name_en': 'Fujairah'},
    {'id': 'ummalquwain', 'name_ar': 'إمارة أم القيوين', 'name_en': 'Umm Al Quwain'},
  ];

  static const List<Map<String, String>> uaeNationalities = [
    {'id': 'ae', 'name_ar': 'إماراتي', 'name_en': 'Emirati'},
    {'id': 'eg', 'name_ar': 'مصري', 'name_en': 'Egyptian'},
    {'id': 'in', 'name_ar': 'هندي', 'name_en': 'Indian'},
    {'id': 'pk', 'name_ar': 'باكستاني', 'name_en': 'Pakistani'},
    {'id': 'ph', 'name_ar': 'فلبيني', 'name_en': 'Filipino'},
    {'id': 'bd', 'name_ar': 'بنغلاديشي', 'name_en': 'Bangladeshi'},
    {'id': 'sy', 'name_ar': 'سوري', 'name_en': 'Syrian'},
    {'id': 'jo', 'name_ar': 'أردني', 'name_en': 'Jordanian'},
    {'id': 'lb', 'name_ar': 'لبناني', 'name_en': 'Lebanese'},
    {'id': 'gb', 'name_ar': 'بريطاني', 'name_en': 'British'},
    {'id': 'np', 'name_ar': 'نيبالي', 'name_en': 'Nepali'},
    {'id': 'lk', 'name_ar': 'سريلانكي', 'name_en': 'Sri Lankan'},
    {'id': 'other', 'name_ar': 'أخرى', 'name_en': 'Other'},
  ];

  static final CountryConfig uae = CountryConfig(
    id: 'ae',
    nameAr: 'الإمارات العربية المتحدة (دبي)',
    nameEn: 'United Arab Emirates (Dubai)',
    shortNameAr: 'دبي والإمارات',
    shortNameEn: 'Dubai & UAE',
    flagEmoji: '🇦🇪',
    phoneCode: '+971',
    currencyAr: 'د.إ',
    currencyEn: 'AED',
    descriptionAr: 'سوق الإمارات (دبي، أبوظبي، الشارقة...)',
    descriptionEn: 'UAE Market (Dubai, Abu Dhabi, Sharjah...)',
    regions: uaeEmirates,
    nationalities: uaeNationalities,
    sectors: KuwaitData.jobSeekerSectors,
  );

  static final List<CountryConfig> allCountries = [
    kuwait,
    saudi,
    uae,
  ];

  static CountryConfig getById(String? id) {
    if (id == null) return kuwait;
    return allCountries.firstWhere(
      (c) => c.id.toLowerCase() == id.toLowerCase(),
      orElse: () => kuwait,
    );
  }
}

import '../models/country_config.dart';

class PaymentInvoice {
  final String invoiceId;
  final double amountKwd;
  final String description;
  final String customerName;
  final String customerEmail;
  final String paymentMethod; // KNET, Visa/Mastercard
  final String status; // success, failed, pending

  PaymentInvoice({
    required this.invoiceId,
    required this.amountKwd,
    required this.description,
    required this.customerName,
    required this.customerEmail,
    required this.paymentMethod,
    this.status = 'success',
  });
}

class PaymentService {
  // Direct Jobs Pricing Packages in Kuwait Dinar (KWD)
  static const List<Map<String, dynamic>> adPackages = [
    {
      'id': 'plan_basic',
      'title_ar': 'نشر إعلان قياسي - أسبوعين',
      'title_en': 'Standard Ad - 2 Weeks',
      'price_kwd': 2.0,
      'currency': 'KWD',
      'currency_ar': 'د.ك',
      'duration_days': 14,
      'badge': 'الأكثر طلباً',
      'badge_en': 'Most Popular',
      'features': [
        'ظهور قياسي في نتائج البحث بالكويت',
        'تواصل مباشر عبر الواتساب والمكالمات',
        'إحصائيات المشاهدات والتقديمات',
      ],
      'features_en': [
        'Standard ranking in Kuwait search results',
        'Direct WhatsApp & phone call contact',
        'Real-time view & application stats',
      ],
    },
    {
      'id': 'plan_pinned',
      'title_ar': 'إعلان مثبت ومميز - شهر كامل',
      'title_en': 'Pinned & Featured Ad - 1 Month',
      'price_kwd': 3.5,
      'currency': 'KWD',
      'currency_ar': 'د.ك',
      'duration_days': 30,
      'badge': 'مميز (Boost)',
      'badge_en': 'Featured (Boost)',
      'features': [
        'تثبيت في أعلى قائمة القسم والمحافظة',
        'شارة إعلان موثق ومميز باللون الذهبي',
        'مضاعفة المشاهدات بنسبة 5 أضعاف',
        'إشعارات للمرشحين المتطابقين',
      ],
      'features_en': [
        'Pinned at top of sector & governorate',
        'Verified golden highlight badge',
        '5x boosted views across Kuwait',
        'Push notifications to matched candidates',
      ],
    },
    {
      'id': 'plan_commercial_vip',
      'title_ar': 'إعلان تجاري VIP - 3 أشهر',
      'title_en': 'Commercial Ad VIP - 3 Months',
      'price_kwd': 12.0,
      'currency': 'KWD',
      'currency_ar': 'د.ك',
      'duration_days': 90,
      'badge': 'الشركات (VIP)',
      'badge_en': 'Business (VIP)',
      'features': [
        'بانر رئيسي متحرك في الشاشة الرئيسية',
        'رابط مباشر للموقع الإلكتروني والواتساب',
        'ظهور مستمر في دليل الشركات الكويتي',
        'دعم فني مخصص 24/7',
      ],
      'features_en': [
        'Prominent home screen top banner',
        'Direct website and WhatsApp links',
        'Permanent presence in Kuwait business directory',
        'Dedicated 24/7 priority support',
      ],
    },
  ];

  static List<Map<String, dynamic>> getPackagesForCountry(CountryConfig country) {
    switch (country.id.toLowerCase()) {
      case 'sa':
        return [
          {
            'id': 'plan_basic',
            'title_ar': 'نشر إعلان قياسي - أسبوعين',
            'title_en': 'Standard Ad - 2 Weeks',
            'price_kwd': 35.0,
            'currency': 'SAR',
            'currency_ar': 'ر.س',
            'duration_days': 14,
            'badge': 'الأكثر طلباً',
            'badge_en': 'Most Popular',
            'features': [
              'ظهور قياسي في نتائج البحث بالسعودية',
              'تواصل مباشر عبر الواتساب والمكالمات',
              'إحصائيات المشاهدات والتقديمات',
            ],
            'features_en': [
              'Standard ranking in Saudi search results',
              'Direct WhatsApp & phone call contact',
              'Real-time view & application stats',
            ],
          },
          {
            'id': 'plan_pinned',
            'title_ar': 'إعلان مثبت ومميز - شهر كامل',
            'title_en': 'Pinned & Featured Ad - 1 Month',
            'price_kwd': 60.0,
            'currency': 'SAR',
            'currency_ar': 'ر.س',
            'duration_days': 30,
            'badge': 'مميز (Boost)',
            'badge_en': 'Featured (Boost)',
            'features': [
              'تثبيت في أعلى قائمة القسم والمنطقة',
              'شارة إعلان موثق ومميز باللون الذهبي',
              'مضاعفة المشاهدات بنسبة 5 أضعاف بالسعودية',
              'إشعارات للمرشحين المتطابقين',
            ],
            'features_en': [
              'Pinned at top of sector & region',
              'Verified golden highlight badge',
              '5x boosted views across Saudi Arabia',
              'Push notifications to matched candidates',
            ],
          },
          {
            'id': 'plan_commercial_vip',
            'title_ar': 'إعلان تجاري VIP - 3 أشهر',
            'title_en': 'Commercial Ad VIP - 3 Months',
            'price_kwd': 150.0,
            'currency': 'SAR',
            'currency_ar': 'ر.س',
            'duration_days': 90,
            'badge': 'الشركات (VIP)',
            'badge_en': 'Business (VIP)',
            'features': [
              'بانر رئيسي متحرك في الشاشة الرئيسية',
              'رابط مباشر للموقع الإلكتروني والواتساب',
              'ظهور مستمر في دليل الشركات بالمملكة',
              'دعم فني مخصص 24/7',
            ],
            'features_en': [
              'Prominent home screen top banner',
              'Direct website and WhatsApp links',
              'Permanent presence in Saudi business directory',
              'Dedicated 24/7 priority support',
            ],
          },
        ];
      case 'ae':
        return [
          {
            'id': 'plan_basic',
            'title_ar': 'نشر إعلان قياسي - أسبوعين',
            'title_en': 'Standard Ad - 2 Weeks',
            'price_kwd': 30.0,
            'currency': 'AED',
            'currency_ar': 'د.إ',
            'duration_days': 14,
            'badge': 'الأكثر طلباً',
            'badge_en': 'Most Popular',
            'features': [
              'ظهور قياسي في نتائج البحث بدبي والإمارات',
              'تواصل مباشر عبر الواتساب والمكالمات',
              'إحصائيات المشاهدات والتقديمات',
            ],
            'features_en': [
              'Standard ranking in Dubai & UAE search results',
              'Direct WhatsApp & phone call contact',
              'Real-time view & application stats',
            ],
          },
          {
            'id': 'plan_pinned',
            'title_ar': 'إعلان مثبت ومميز - شهر كامل',
            'title_en': 'Pinned & Featured Ad - 1 Month',
            'price_kwd': 55.0,
            'currency': 'AED',
            'currency_ar': 'د.إ',
            'duration_days': 30,
            'badge': 'مميز (Boost)',
            'badge_en': 'Featured (Boost)',
            'features': [
              'تثبيت في أعلى قائمة القسم والإمارة',
              'شارة إعلان موثق ومميز باللون الذهبي',
              'مضاعفة المشاهدات بنسبة 5 أضعاف بالإمارات',
              'إشعارات للمرشحين المتطابقين',
            ],
            'features_en': [
              'Pinned at top of sector & emirate',
              'Verified golden highlight badge',
              '5x boosted views across UAE',
              'Push notifications to matched candidates',
            ],
          },
          {
            'id': 'plan_commercial_vip',
            'title_ar': 'إعلان تجاري VIP - 3 أشهر',
            'title_en': 'Commercial Ad VIP - 3 Months',
            'price_kwd': 140.0,
            'currency': 'AED',
            'currency_ar': 'د.إ',
            'duration_days': 90,
            'badge': 'الشركات (VIP)',
            'badge_en': 'Business (VIP)',
            'features': [
              'بانر رئيسي متحرك في الشاشة الرئيسية',
              'رابط مباشر للموقع الإلكتروني والواتساب',
              'ظهور مستمر في دليل الشركات الإماراتي',
              'دعم فني مخصص 24/7',
            ],
            'features_en': [
              'Prominent home screen top banner',
              'Direct website and WhatsApp links',
              'Permanent presence in UAE business directory',
              'Dedicated 24/7 priority support',
            ],
          },
        ];
      case 'kw':
      default:
        return adPackages;
    }
  }

  Future<PaymentInvoice> processMyFatoorahPayment({
    required double amountKwd,
    required String description,
    required String customerName,
    required String customerEmail,
    required String paymentMethod,
  }) async {
    // Simulates MyFatoorah gateway call
    await Future.delayed(const Duration(milliseconds: 1500));
    return PaymentInvoice(
      invoiceId: 'MF_KW_${DateTime.now().millisecondsSinceEpoch}',
      amountKwd: amountKwd,
      description: description,
      customerName: customerName,
      customerEmail: customerEmail,
      paymentMethod: paymentMethod,
      status: 'success',
    );
  }
}

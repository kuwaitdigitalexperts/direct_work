<?php

namespace App\Constants;

class MarketData
{
    public static function getCountries(): array
    {
        return [
            'kw' => [
                'id' => 'kw',
                'name_en' => 'Kuwait',
                'name_ar' => 'دولة الكويت',
                'short_name_en' => 'Kuwait',
                'short_name_ar' => 'الكويت',
                'flag' => '🇰🇼',
                'phone_code' => '+965',
                'currency_en' => 'KWD',
                'currency_ar' => 'د.ك',
                'ad_fee' => 2.0,
                'fee_display' => '2',
                'regions' => [
                    ['id' => 'capital', 'name_ar' => 'محافظة العاصمة', 'name_en' => 'Capital (Al Asimah)'],
                    ['id' => 'hawalli', 'name_ar' => 'محافظة حولي', 'name_en' => 'Hawalli'],
                    ['id' => 'farwaniya', 'name_ar' => 'محافظة الفروانية', 'name_en' => 'Farwaniya'],
                    ['id' => 'ahmadi', 'name_ar' => 'محافظة الأحمدي', 'name_en' => 'Ahmadi'],
                    ['id' => 'jahra', 'name_ar' => 'محافظة الجهراء', 'name_en' => 'Jahra'],
                    ['id' => 'mubarak', 'name_ar' => 'محافظة مبارك الكبير', 'name_en' => 'Mubarak Al-Kabeer'],
                ],
            ],
            'sa' => [
                'id' => 'sa',
                'name_en' => 'Saudi Arabia',
                'name_ar' => 'المملكة العربية السعودية',
                'short_name_en' => 'Saudi Arabia',
                'short_name_ar' => 'السعودية',
                'flag' => '🇸🇦',
                'phone_code' => '+966',
                'currency_en' => 'SAR',
                'currency_ar' => 'ر.س',
                'ad_fee' => 35.0,
                'fee_display' => '35',
                'regions' => [
                    ['id' => 'riyadh', 'name_ar' => 'منطقة الرياض', 'name_en' => 'Riyadh Region'],
                    ['id' => 'makkah', 'name_ar' => 'منطقة مكة المكرمة (جدة والطائف)', 'name_en' => 'Makkah Region (Jeddah & Taif)'],
                    ['id' => 'eastern', 'name_ar' => 'المنطقة الشرقية (الدمام والخبر)', 'name_en' => 'Eastern Province (Dammam & Khobar)'],
                    ['id' => 'madinah', 'name_ar' => 'منطقة المدينة المنورة', 'name_en' => 'Madinah Region'],
                    ['id' => 'qassim', 'name_ar' => 'منطقة القصيم (بريدة وعنيزة)', 'name_en' => 'Al-Qassim Region'],
                    ['id' => 'asir', 'name_ar' => 'منطقة عسير (أبها وخميس مشيط)', 'name_en' => 'Asir Region (Abha)'],
                ],
            ],
            'ae' => [
                'id' => 'ae',
                'name_en' => 'United Arab Emirates',
                'name_ar' => 'الإمارات العربية المتحدة',
                'short_name_en' => 'Dubai / UAE',
                'short_name_ar' => 'دبي / الإمارات',
                'flag' => '🇦🇪',
                'phone_code' => '+971',
                'currency_en' => 'AED',
                'currency_ar' => 'د.إ',
                'ad_fee' => 30.0,
                'fee_display' => '30',
                'regions' => [
                    ['id' => 'dubai', 'name_ar' => 'إمارة دبي', 'name_en' => 'Dubai'],
                    ['id' => 'abu_dhabi', 'name_ar' => 'إمارة أبوظبي', 'name_en' => 'Abu Dhabi'],
                    ['id' => 'sharjah', 'name_ar' => 'إمارة الشارقة', 'name_en' => 'Sharjah'],
                    ['id' => 'ajman', 'name_ar' => 'إمارة عجمان', 'name_en' => 'Ajman'],
                    ['id' => 'ras_al_khaimah', 'name_ar' => 'إمارة رأس الخيمة', 'name_en' => 'Ras Al Khaimah'],
                    ['id' => 'fujairah', 'name_ar' => 'إمارة الفجيرة', 'name_en' => 'Fujairah'],
                ],
            ],
        ];
    }

    public static function getCountry(string $code = 'kw'): array
    {
        $countries = self::getCountries();
        return $countries[$code] ?? $countries['kw'];
    }

    public static function getNationalities(): array
    {
        return [
            ['id' => 'kw', 'name_ar' => 'كويتي', 'name_en' => 'Kuwaiti'],
            ['id' => 'sa', 'name_ar' => 'سعودي', 'name_en' => 'Saudi'],
            ['id' => 'ae', 'name_ar' => 'إماراتي', 'name_en' => 'Emirati'],
            ['id' => 'eg', 'name_ar' => 'مصري', 'name_en' => 'Egyptian'],
            ['id' => 'in', 'name_ar' => 'هندي', 'name_en' => 'Indian'],
            ['id' => 'pk', 'name_ar' => 'باكستاني', 'name_en' => 'Pakistani'],
            ['id' => 'bd', 'name_ar' => 'بنغلاديشي', 'name_en' => 'Bangladeshi'],
            ['id' => 'ph', 'name_ar' => 'فلبيني', 'name_en' => 'Filipino'],
            ['id' => 'sy', 'name_ar' => 'سوري', 'name_en' => 'Syrian'],
            ['id' => 'jo', 'name_ar' => 'أردني', 'name_en' => 'Jordanian'],
            ['id' => 'lb', 'name_ar' => 'لبناني', 'name_en' => 'Lebanese'],
            ['id' => 'np', 'name_ar' => 'نيبالي', 'name_en' => 'Nepali'],
            ['id' => 'lk', 'name_ar' => 'سريلانكي', 'name_en' => 'Sri Lankan'],
            ['id' => 'other', 'name_ar' => 'أخرى', 'name_en' => 'Other'],
        ];
    }

    public static function getSectors(): array
    {
        static $sectors = null;
        if ($sectors === null) {
            $path = storage_path('app/sectors.json');
            if (file_exists($path)) {
                $sectors = json_decode(file_get_contents($path), true) ?? [];
            } else {
                $sectors = [];
            }
        }
        return $sectors;
    }

    public static function getSector(string $code): ?array
    {
        foreach (self::getSectors() as $sector) {
            if (($sector['code'] ?? '') === $code) {
                return $sector;
            }
        }
        return null;
    }

    public static function getAdPackages(string $countryCode = 'kw'): array
    {
        $country = self::getCountry($countryCode);
        $currEn = $country['currency_en'];
        $currAr = $country['currency_ar'];

        if ($countryCode === 'sa') {
            return [
                [
                    'id' => 'plan_basic',
                    'title_ar' => 'إعلان قياسي (3 أشهر)',
                    'title_en' => 'Standard Ad (3 Months)',
                    'price' => 35,
                    'price_display' => '35',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'الأكثر طلباً',
                    'badge_en' => 'Most Popular',
                    'features' => [
                        'صلاحية ظهور كاملة لمدة 90 يوماً',
                        'ظهور فوري لأصحاب العمل والشركات',
                        'تواصل مباشر عبر الواتساب والاتصال والمحادثة',
                        'إرفاق السيرة الذاتية (CV) وحتى 5 شهادات',
                    ],
                ],
                [
                    'id' => 'plan_pinned',
                    'title_ar' => 'إعلان مثبت في صدارة القطاع',
                    'title_en' => 'Pinned Sector Ad',
                    'price' => 60,
                    'price_display' => '60',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'ظهور مضاعف 5x',
                    'badge_en' => '5x Views',
                    'features' => [
                        'تثبيت الإعلان بأعلى نتائج بحث القطاع',
                        'شارة ذهبية مميزة لجذب الشركات',
                        'ظهور في قسم المرشحين الموصى بهم',
                        'تنبيهات فورية عند مشاهدة ملفك',
                    ],
                ],
                [
                    'id' => 'plan_vip',
                    'title_ar' => 'باقة VIP للتوظيف السريع',
                    'title_en' => 'VIP Fast-Hire Package',
                    'price' => 150,
                    'price_display' => '150',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'باقة النخبة',
                    'badge_en' => 'VIP Elite',
                    'features' => [
                        'ترشيح مباشر للشركات المتعاقدة في السعودية',
                        'تثبيت في الصفحة الرئيسية والقطاع معاً',
                        'دعم خاص وتحديث دوري للملف الشخصي',
                        'إبراز الشهادات والخبرات بالكامل',
                    ],
                ],
            ];
        }

        if ($countryCode === 'ae') {
            return [
                [
                    'id' => 'plan_basic',
                    'title_ar' => 'إعلان قياسي (3 أشهر)',
                    'title_en' => 'Standard Ad (3 Months)',
                    'price' => 30,
                    'price_display' => '30',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'الأكثر طلباً',
                    'badge_en' => 'Most Popular',
                    'features' => [
                        'صلاحية ظهور كاملة لمدة 90 يوماً',
                        'ظهور فوري لأصحاب العمل في دبي والإمارات',
                        'تواصل مباشر عبر الواتساب والاتصال والمحادثة',
                        'إرفاق السيرة الذاتية (CV) وحتى 5 شهادات',
                    ],
                ],
                [
                    'id' => 'plan_pinned',
                    'title_ar' => 'إعلان مثبت في صدارة القطاع',
                    'title_en' => 'Pinned Sector Ad',
                    'price' => 55,
                    'price_display' => '55',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'ظهور مضاعف 5x',
                    'badge_en' => '5x Views',
                    'features' => [
                        'تثبيت الإعلان بأعلى نتائج بحث القطاع',
                        'شارة ذهبية مميزة لجذب الشركات',
                        'ظهور في قسم المرشحين الموصى بهم',
                        'تنبيهات فورية عند مشاهدة ملفك',
                    ],
                ],
                [
                    'id' => 'plan_vip',
                    'title_ar' => 'باقة VIP للتوظيف السريع',
                    'title_en' => 'VIP Fast-Hire Package',
                    'price' => 140,
                    'price_display' => '140',
                    'currency' => $currEn,
                    'currency_ar' => $currAr,
                    'badge' => 'باقة النخبة',
                    'badge_en' => 'VIP Elite',
                    'features' => [
                        'ترشيح مباشر للشركات في دبي وأبوظبي',
                        'تثبيت في الصفحة الرئيسية والقطاع معاً',
                        'دعم خاص وتحديث دوري للملف الشخصي',
                        'إبراز الشهادات والخبرات بالكامل',
                    ],
                ],
            ];
        }

        // Kuwait default (2 KWD)
        return [
            [
                'id' => 'plan_basic',
                'title_ar' => 'إعلان قياسي (3 أشهر)',
                'title_en' => 'Standard Ad (3 Months)',
                'price' => 2,
                'price_display' => '2',
                'currency' => $currEn,
                'currency_ar' => $currAr,
                'badge' => 'الأكثر طلباً',
                'badge_en' => 'Most Popular',
                'features' => [
                    'صلاحية ظهور كاملة لمدة 90 يوماً',
                    'ظهور فوري لكبرى الشركات وأصحاب العمل في الكويت',
                    'تواصل مباشر عبر الواتساب والاتصال والمحادثة',
                    'إرفاق السيرة الذاتية (CV) والشهادات',
                ],
            ],
            [
                'id' => 'plan_pinned',
                'title_ar' => 'إعلان مثبت في صدارة القطاع',
                'title_en' => 'Pinned Sector Ad',
                'price' => 3.5,
                'price_display' => '3.5',
                'currency' => $currEn,
                'currency_ar' => $currAr,
                'badge' => 'ظهور مضاعف 5x',
                'badge_en' => '5x Views',
                'features' => [
                    'تثبيت الإعلان بأعلى نتائج بحث القطاع',
                    'شارة ذهبية مميزة لجذب الشركات',
                    'ظهور في قسم المرشحين الموصى بهم',
                    'تنبيهات فورية عند مشاهدة ملفك',
                ],
            ],
            [
                'id' => 'plan_vip',
                'title_ar' => 'باقة VIP للتوظيف السريع',
                'title_en' => 'VIP Fast-Hire Package',
                'price' => 12,
                'price_display' => '12',
                'currency' => $currEn,
                'currency_ar' => $currAr,
                'badge' => 'باقة النخبة',
                'badge_en' => 'VIP Elite',
                'features' => [
                    'ترشيح مباشر للشركات والمؤسسات الكويتية الكبرى',
                    'تثبيت في الصفحة الرئيسية والقطاع معاً',
                    'دعم ومتابعة أسبوعية للملف',
                    'إبراز الشهادات والخبرات بالكامل',
                ],
            ],
        ];
    }
}

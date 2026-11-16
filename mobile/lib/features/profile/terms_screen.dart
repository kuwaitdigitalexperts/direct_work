import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.translate('terms_conditions')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.isArabic
                  ? 'شروط الاستخدام والتوظيف المباشر في الكويت'
                  : 'Terms of Use & Direct Employment in Kuwait',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.isArabic
                  ? 'تحدد هذه الشروط والأحكام القواعد واللوائح التنظيمية لاستخدام تطبيق "دايركت وورك الكويت"، المخصص حصرياً لسوق العمل والخدمات داخل دولة الكويت وفقاً للقوانين واللوائح المعمول بها.'
                  : 'These Terms & Conditions govern the use of the "Direct Work Kuwait" application, exclusively tailored for the State of Kuwait job and services marketplace.',
              style: const TextStyle(fontSize: 14, height: 1.6, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.isArabic ? '1. التعريفات ونطاق الخدمة' : '1. Scope of Service',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'يقدم التطبيق منصة ربط تقنية مباشرة بين الباحثين عن عمل، وأصحاب الأعمال والشركات، ومقدمي الخدمات التجارية داخل محافظات دولة الكويت الست.'
                  : 'The application acts as a direct matchmaking platform connecting job seekers, employers, companies, and commercial services across all six Kuwait governorates.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.isArabic ? '2. الالتزام بقانون العمل الكويتي' : '2. Kuwait Labor Law Compliance',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'يقر أصحاب الأعمال بالالتزام بقانون العمل الكويتي في القطاع الأهلي رقم 6 لسنة 2010 وتعديلاته، والقرارات المنظمة الصادرة عن الهيئة العامة للقوى العاملة بدولة الكويت.'
                  : 'Employers acknowledge compliance with Kuwait Private Sector Labor Law No. 6 of 2010 and regulations issued by the Public Authority for Manpower (PAM).',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.isArabic ? '3. شروط نشر الإعلانات والخدمات' : '3. Ad Posting Regulations',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'يمنع منعاً باتاً نشر أي إعلانات مضللة أو غير حقيقية أو تخالف الآداب العامة وقوانين وزارة التجارة والصناعة الكويتية. يحق لإدارة التطبيق إيقاف أي إعلان مخالف فوراً.'
                  : 'Posting misleading, fraudulent, or unlawful advertisements violating Kuwait Ministry of Commerce standards is strictly prohibited.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.isArabic ? '4. الرسوم وعمليات الدفع' : '4. Fees & Payments',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'تتم جميع المعاملات المالية بالدينار الكويتي (KWD) عبر بوابة MyFatoorah المرخصة، وتعد جميع الرسوم المدفوعة مقابل خدمات التثبيت والترقية الرقمية نهائية بعد التفعيل.'
                  : 'All transactions are processed in Kuwaiti Dinar (KWD) via the certified MyFatoorah gateway for KNET and credit cards.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

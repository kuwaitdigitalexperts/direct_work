import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.translate('privacy_policy')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.isArabic
                  ? 'حماية بيانات مستخدمي تطبيق دايركت وورك في الكويت'
                  : 'Data Protection & Privacy Policy in Kuwait',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.isArabic
                  ? 'نولي في دايركت وورك الكويت أهمية قصوى لخصوصية وسرية بياناتك الشخصية وبيانات السير الذاتية، ونلتزم بحمايتها وفق أعلى معايير الأمان التقني وقوانين دولة الكويت المنظمة لحماية البيانات الرقمية.'
                  : 'At Direct Work Kuwait, we place paramount importance on the confidentiality and security of personal and resume data in accordance with the laws of the State of Kuwait.',
              style: const TextStyle(fontSize: 14, height: 1.6, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.isArabic ? '1. البيانات التي نقوم بجمعها' : '1. Collected Data',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'الاسم الكامل، رقم الهاتف الكويتي، البريد الإلكتروني، المحافظة، التخصص المهني، سنوات الخبرة، ملفات السيرة الذاتية (CV)، وبيانات الترخيص التجاري للشركات.'
                  : 'Full name, Kuwait phone number, email, governorate, profession, years of experience, CV documents, and company commercial license data.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.isArabic ? '2. كيفية استخدام البيانات' : '2. How Data is Used',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'تُستخدم البيانات فقط لتمكين التواصل المباشر بين أطراف التوظيف والخدمات داخل دولة الكويت، وعرض السير الذاتية لأصحاب العمل المصرح لهم فقط.'
                  : 'Data is used solely to facilitate direct communication between hiring parties and candidates across Kuwait, visible only to authorized employers.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.isArabic ? '3. حقوق المستخدم وحذف الحساب' : '3. User Rights & Account Deletion',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.isArabic
                  ? 'يحق للمستخدم في أي وقت تعديل بياناته، أو حذف حسابه نهائياً وجميع بياناته المرفقة وسيرته الذاتية من خوادم التطبيق فوراً بنقرة واحدة من صفحة الملف الشخصي.'
                  : 'Users reserve the right at any time to edit or permanently delete their account and associated resumes with 1-click from the Profile settings.',
              style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/country_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../providers/user_ads_provider.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class PostJobScreen extends ConsumerStatefulWidget {
  const PostJobScreen({super.key});

  @override
  ConsumerState<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends ConsumerState<PostJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _professionController = TextEditingController();
  final _salaryController = TextEditingController();
  final _descController = TextEditingController();
  final _reqController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedSectorCode = KuwaitData.sectors.first['code'];
  String _selectedGovernorateId = KuwaitData.governorates.first['id']!;
  String _selectedWorkType = 'full_time';
  String _selectedCategory = 'all';
  bool _wantBoost = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    if (user != null) {
      if (user.companyName != null && user.companyName!.isNotEmpty) {
        _companyController.text = user.companyName!;
      } else {
        _companyController.text = user.fullName;
      }
      _whatsappController.text = user.phone.replaceAll('+965 ', '').replaceAll(' ', '');
      _phoneController.text = user.phone;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _professionController.dispose();
    _salaryController.dispose();
    _descController.dispose();
    _reqController.dispose();
    _whatsappController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitJob(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final activeCountry = ref.read(countryProvider);
    final sector = KuwaitData.sectors.firstWhere((s) => s['code'] == _selectedSectorCode);
    final gov = activeCountry.regions.firstWhere(
      (g) => g['id'] == _selectedGovernorateId,
      orElse: () => KuwaitData.governorates.firstWhere(
        (g) => g['id'] == _selectedGovernorateId,
        orElse: () => activeCountry.regions.first,
      ),
    );

    final requirementsList = _reqController.text
        .split('\n')
        .map((r) => r.trim())
        .where((r) => r.isNotEmpty)
        .toList();

    if (requirementsList.isEmpty) {
      requirementsList.add(l10n.isArabic ? 'إقامة كويتية قابلة للتحويل مادة 18' : 'Valid Kuwait transferable visa (Article 18)');
      requirementsList.add(l10n.isArabic ? 'خبرة عملية موثقة داخل الكويت' : 'Documented work experience in Kuwait');
    }

    final newJob = JobModel(
      id: 'job_kw_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      companyName: _companyController.text.trim(),
      sectorCode: _selectedSectorCode,
      sectorName: l10n.isArabic ? sector['name_ar'] : sector['name_en'],
      professionName: _professionController.text.trim().isNotEmpty
          ? _professionController.text.trim()
          : (l10n.isArabic ? sector['name_ar'] : sector['name_en']),
      governorateId: _selectedGovernorateId,
      governorateName: l10n.isArabic ? gov['name_ar']! : gov['name_en']!,
      workType: _selectedWorkType,
      candidateCategory: _selectedCategory,
      salaryKwd: double.tryParse(_salaryController.text),
      description: _descController.text.trim(),
      requirements: requirementsList,
      whatsappNumber: '965${_whatsappController.text.trim().replaceAll('+', '').replaceAll('965', '')}',
      phoneNumber: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : '+965 22000000',
      isPinned: _wantBoost,
      isFeatured: _wantBoost,
      viewsCount: 1,
      createdAt: DateTime.now(),
    );

    // Save into both global jobs and user's posted ads
    await ref.read(jobsProvider.notifier).addJob(newJob);
    ref.read(userAdsProvider.notifier).addJob(newJob);

    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          content: Text(
            l10n.isArabic
                ? 'تم نشر إعلان الوظيفة الشاغرة بنجاح في سوق العمل الكويتي!'
                : 'Job vacancy published successfully in the Kuwait job market!',
          ),
        ),
      );

      if (_wantBoost) {
        context.push('/pricing-plans');
      } else {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activeCountry = ref.watch(countryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.isArabic ? 'أعلن عن وظيفة شاغرة' : 'Post a Job Vacancy'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add_business_rounded, color: AppColors.primary, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.isArabic ? 'انشر وظيفة شاغرة لشركتك' : 'Publish a Vacancy for Your Business',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.isArabic
                                  ? 'تواصل مباشرة مع مئات الكفاءات وأصحاب المهن المعتمدين في الكويت بدون وسطاء.'
                                  : 'Connect directly with certified talent and professionals across Kuwait.',
                              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Job Title
                AppTextField(
                  controller: _titleController,
                  label: l10n.isArabic ? 'مسمى الوظيفة الشاغرة' : 'Job Title',
                  hint: l10n.isArabic ? 'مثال: فني تكييف مركزي وصيانة وحدات' : 'e.g. Central AC Maintenance Technician',
                  prefixIcon: Icons.work_outline,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى إدخال مسمى الوظيفة' : 'Please enter job title')
                      : null,
                ),
                const SizedBox(height: 14),

                // Company Name
                AppTextField(
                  controller: _companyController,
                  label: l10n.isArabic ? 'اسم الشركة أو المنشأة' : 'Company or Business Name',
                  hint: l10n.isArabic ? 'شركة الأفق للمقاولات والتجارة' : 'Al-Ofoq General Contracting Co.',
                  prefixIcon: Icons.business,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى إدخال اسم الشركة' : 'Please enter company name')
                      : null,
                ),
                const SizedBox(height: 14),

                // Sector Dropdown
                Text(
                  l10n.isArabic ? 'القطاع الوظيفي' : 'Job Sector',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: KuwaitData.sectors.any((s) => s['code'] == _selectedSectorCode)
                          ? _selectedSectorCode
                          : KuwaitData.sectors.first['code'],
                      isExpanded: true,
                      items: KuwaitData.sectors.map((s) {
                        return DropdownMenuItem<String>(
                          value: s['code'],
                          child: Text(l10n.isArabic ? s['name_ar'] : s['name_en']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedSectorCode = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Profession
                AppTextField(
                  controller: _professionController,
                  label: l10n.isArabic ? 'المهنة أو التخصص الدقيق' : 'Specialty / Profession',
                  hint: l10n.isArabic ? 'مثال: فني تكييف شيلرات' : 'e.g. Chiller AC Specialist',
                  prefixIcon: Icons.handyman_outlined,
                ),
                const SizedBox(height: 14),

                // Governorate / Region
                Text(
                  l10n.isArabic
                      ? 'المنطقة / المحافظة (${activeCountry.nameAr})'
                      : 'Region / Area (${activeCountry.nameEn})',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: activeCountry.regions.any((g) => g['id'] == _selectedGovernorateId)
                          ? _selectedGovernorateId
                          : activeCountry.regions.first['id'],
                      isExpanded: true,
                      items: activeCountry.regions.map((g) {
                        return DropdownMenuItem<String>(
                          value: g['id'],
                          child: Text(l10n.isArabic ? g['name_ar']! : g['name_en']!),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedGovernorateId = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Work Type
                Text(
                  l10n.isArabic ? 'نوع الدوام' : 'Work Type',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: ['full_time', 'part_time', 'freelance'].contains(_selectedWorkType)
                          ? _selectedWorkType
                          : 'full_time',
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 'full_time',
                          child: Text(l10n.isArabic ? 'دوام كامل' : 'Full-Time'),
                        ),
                        DropdownMenuItem(
                          value: 'part_time',
                          child: Text(l10n.isArabic ? 'دوام جزئي داخل الكويت' : 'Part-Time in Kuwait'),
                        ),
                        DropdownMenuItem(
                          value: 'freelance',
                          child: Text(l10n.isArabic ? 'عمل حر / مؤقت' : 'Freelance / Temporary'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedWorkType = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Expected Salary (KWD)
                AppTextField(
                  controller: _salaryController,
                  label: l10n.isArabic ? 'الراتب الشهري المتوقع بالدينار الكويتي (KWD)' : 'Monthly Salary in KWD',
                  hint: '450',
                  prefixIcon: Icons.payments_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),

                // Job Description
                AppTextField(
                  controller: _descController,
                  label: l10n.isArabic ? 'وصف الوظيفة والمهام' : 'Job Description & Duties',
                  hint: l10n.isArabic
                      ? 'اشرح المهام اليومية، أوقات العمل، والبدلات المتوفرة...'
                      : 'Describe daily tasks, working hours, benefits, etc...',
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى كتابة وصف للوظيفة' : 'Please enter job description')
                      : null,
                ),
                const SizedBox(height: 14),

                // Requirements
                AppTextField(
                  controller: _reqController,
                  label: l10n.isArabic ? 'شروط ومتطلبات الوظيفة (سطر لكل شرط)' : 'Requirements (1 per line)',
                  hint: l10n.isArabic
                      ? 'خبرة سنتين في الكويت\nرخصة قيادة كويتية صالحة\nإقامة مادة 18 قابلة للتحويل'
                      : '2 years Kuwait experience\nValid Kuwait driving license\nTransferable residency',
                  maxLines: 3,
                ),
                const SizedBox(height: 14),

                // Kuwait WhatsApp
                AppTextField(
                  controller: _whatsappController,
                  label: l10n.isArabic ? 'رقم الواتساب للتواصل المباشر في الكويت' : 'Direct WhatsApp Number in Kuwait',
                  hint: '9XXXXXXX / 6XXXXXXX',
                  prefixWidget: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🇰🇼', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 6),
                        Text('+965', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        SizedBox(width: 6),
                        SizedBox(height: 20, child: VerticalDivider(width: 1, color: AppColors.border)),
                        SizedBox(width: 6),
                      ],
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().length < 8)
                      ? (l10n.isArabic ? 'يرجى إدخال رقم واتساب كويتي صحيح' : 'Please enter valid Kuwait WhatsApp')
                      : null,
                ),
                const SizedBox(height: 14),

                // Direct Phone
                AppTextField(
                  controller: _phoneController,
                  label: l10n.isArabic ? 'هاتف الاتصال بالشركة' : 'Company Phone Number',
                  hint: '+965 22000000',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 18),

                // Boost Checkbox
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _wantBoost ? AppColors.primaryLight : AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _wantBoost ? AppColors.primary : AppColors.border,
                      width: _wantBoost ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _wantBoost,
                        activeColor: AppColors.primary,
                        onChanged: (v) => setState(() => _wantBoost = v ?? false),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.isArabic ? 'تثبيت وترقية الإعلان (Boost via MyFatoorah)' : 'Boost & Pin Ad via MyFatoorah',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            ),
                            Text(
                              l10n.isArabic
                                  ? 'تثبيت في أعلى القائمة ومضاعفة المشاهدات بنسبة 5 أضعاف'
                                  : 'Pin at top of results and 5x candidate views',
                              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Submit Button
                AppButton(
                  text: l10n.isArabic ? 'نشر إعلان الوظيفة الشاغرة' : 'Publish Job Vacancy',
                  isLoading: _isSubmitting,
                  onPressed: () => _submitJob(l10n),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

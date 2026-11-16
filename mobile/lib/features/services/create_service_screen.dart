import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/service_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/services_provider.dart';
import '../../providers/user_ads_provider.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class CreateServiceScreen extends ConsumerStatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  ConsumerState<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends ConsumerState<CreateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedCatId = KuwaitData.serviceCategories.first['id'];
  String _selectedGovernorate = 'all';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    if (user != null) {
      _phoneController.text = user.phone.replaceAll('+965 ', '');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitService(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final user = ref.read(authProvider).user;
    final cat = KuwaitData.serviceCategories.firstWhere((c) => c['id'] == _selectedCatId);

    String govName = l10n.isArabic ? 'جميع محافظات الكويت' : 'All Kuwait Governorates';
    if (_selectedGovernorate != 'all') {
      final foundGov = KuwaitData.governorates.firstWhere(
        (g) => g['id'] == _selectedGovernorate,
        orElse: () => {'name_ar': 'الكويت', 'name_en': 'Kuwait'},
      );
      govName = l10n.isArabic ? foundGov['name_ar']! : foundGov['name_en']!;
    }

    final service = ServiceModel(
      id: 'srv_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      categoryId: _selectedCatId,
      categoryName: l10n.isArabic ? cat['name_ar'] : cat['name_en'],
      subcategory: (cat['subcategories'] as List).first,
      description: _descController.text.trim(),
      priceKwd: double.tryParse(_priceController.text),
      providerName: user?.fullName ?? (l10n.isArabic ? 'مزود خدمة بالكويت' : 'Kuwait Service Provider'),
      phoneNumber: '+965 ${_phoneController.text.trim()}',
      whatsappNumber: '965${_phoneController.text.trim()}',
      governorateName: govName,
      imageUrls: [
        'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=800&q=80',
      ],
      createdAt: DateTime.now(),
    );

    await ref.read(servicesProvider.notifier).addService(service);
    ref.read(userAdsProvider.notifier).addService(service);
    setState(() => _isSubmitting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          content: Text(l10n.translate('service_published_msg')),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.isArabic ? 'إضافة خدمة جديدة في الكويت' : 'Post New Service in Kuwait'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.isArabic ? 'بيانات الإعلان الخدمي' : 'Service Ad Details',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.isArabic
                      ? 'انشر خدمات الصيانة، النقل، التصليح للوصول للعملاء في الكويت'
                      : 'Advertise maintenance, transport, and repair services in Kuwait',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),

                // Title
                AppTextField(
                  controller: _titleController,
                  label: l10n.isArabic ? 'عنوان الخدمة الرئيسي' : 'Service Title',
                  hint: l10n.isArabic ? 'مثال: تصليح تكييف مركزي وصيانة وحدات 24 ساعة' : 'e.g. 24/7 Central AC Maintenance & Repair',
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى إدخال عنوان الخدمة' : 'Please enter service title')
                      : null,
                ),
                const SizedBox(height: 14),

                // Category Dropdown
                Text(
                  l10n.isArabic ? 'تصنيف الخدمة' : 'Service Category',
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
                      value: KuwaitData.serviceCategories.any((c) => c['id'] == _selectedCatId)
                          ? _selectedCatId
                          : KuwaitData.serviceCategories.first['id'],
                      isExpanded: true,
                      items: KuwaitData.serviceCategories.map((c) {
                        return DropdownMenuItem<String>(
                          value: c['id'],
                          child: Text(l10n.isArabic ? c['name_ar'] : c['name_en']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedCatId = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Description
                AppTextField(
                  controller: _descController,
                  label: l10n.isArabic ? 'تفاصيل الخدمة والضمان' : 'Service Details & Warranty',
                  hint: l10n.isArabic
                      ? 'اشرح ما تقدمه بدقة، نوع القطع، الكفالة، ومناطق التغطية...'
                      : 'Describe your service, warranty, parts, and covered areas...',
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى كتابة تفاصيل الخدمة' : 'Please describe your service')
                      : null,
                ),
                const SizedBox(height: 14),

                // Price (KWD)
                AppTextField(
                  controller: _priceController,
                  label: l10n.isArabic ? 'السعر المبدئي بالدينار الكويتي (KWD)' : 'Starting Price in KWD',
                  hint: '15',
                  prefixIcon: Icons.payments_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),

                // Kuwait Phone
                AppTextField(
                  controller: _phoneController,
                  label: l10n.isArabic ? 'رقم هاتف التواصل والواتساب في الكويت' : 'Contact Phone & WhatsApp (Kuwait)',
                  hint: '9XXXXXXX / 6XXXXXXX',
                  prefixIcon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                  validator: (v) => (v == null || v.trim().length < 8)
                      ? (l10n.isArabic ? 'يرجى إدخال رقم كويتي صحيح' : 'Please enter a valid Kuwait phone number')
                      : null,
                ),
                const SizedBox(height: 14),

                // Governorate
                Text(
                  l10n.isArabic ? 'نطاق التغطية داخل الكويت' : 'Coverage Area in Kuwait',
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
                      value: (_selectedGovernorate == 'all' || KuwaitData.governorates.any((g) => g['id'] == _selectedGovernorate))
                          ? _selectedGovernorate
                          : 'all',
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text(l10n.translate('all_kuwait_govs')),
                        ),
                        ...KuwaitData.governorates.map((g) {
                          return DropdownMenuItem(
                            value: g['id'],
                            child: Text(l10n.isArabic ? g['name_ar']! : g['name_en']!),
                          );
                        }),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedGovernorate = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                AppButton(
                  text: l10n.isArabic ? 'نشر الإعلان الخدمي' : 'Publish Service Ad',
                  isLoading: _isSubmitting,
                  onPressed: () => _submitService(l10n),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


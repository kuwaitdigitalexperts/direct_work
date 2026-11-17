import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/country_provider.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class CompanyRegisterScreen extends ConsumerStatefulWidget {
  const CompanyRegisterScreen({super.key});

  @override
  ConsumerState<CompanyRegisterScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends ConsumerState<CompanyRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactPersonController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Commented out fields for next version:
  // final _licenseController = TextEditingController();
  // String _selectedGovernorate = KuwaitData.governorates.first['name_ar']!;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = true;

  @override
  void dispose() {
    _contactPersonController.dispose();
    _companyNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.translate('agree_terms_company_msg'))),
      );
      return;
    }

    final active = ref.read(countryProvider);
    final phoneDigits = _phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    final fullPhone = '${active.phoneCode} $phoneDigits';

    final success = await ref.read(authProvider.notifier).registerCompany(
      companyName: _companyNameController.text.trim(),
      contactPerson: _contactPersonController.text.trim(),
      email: _emailController.text.trim(),
      phone: fullPhone,
      password: _passwordController.text,
      commercialLicense: '${active.id.toUpperCase()}-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      governorate: active.regions.first['name_ar'] ?? 'المنطقة الرئيسية',
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          content: Text(l10n.translate('company_registered_msg')),
        ),
      );
      context.go('/home');
    } else if (mounted) {
      final err = ref.read(authProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Text(err ?? (l10n.isArabic ? 'فشل تسجيل الشركة' : 'Company registration failed')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    final activeCountry = ref.watch(countryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.isArabic ? 'تسجيل شركة / صاحب عمل' : 'Company / Employer Registration'),
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
                  l10n.isArabic
                      ? 'انضم كصاحب عمل في ${activeCountry.nameAr}'
                      : 'Join as an Employer in ${activeCountry.nameEn}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.isArabic
                      ? 'انشر وظائفك الشاغرة واستقطب أفضل الكوادر المهنية والعمالية مباشرة'
                      : 'Post vacancies and hire top professionals and skilled workers directly',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => context.push('/country-selection?role=company'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(activeCountry.flagEmoji, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 8),
                        Text(
                          l10n.isArabic ? activeCountry.nameAr : activeCountry.nameEn,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.edit_rounded, size: 14, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (authState.errorMessage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            authState.errorMessage!,
                            style: const TextStyle(
                              color: Color(0xFFDC2626),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // 1. Full Name
                AppTextField(
                  controller: _contactPersonController,
                  label: l10n.isArabic ? 'الاسم الكامل' : 'Full Name',
                  hint: l10n.isArabic ? 'أدخل الاسم الكامل' : 'Enter full name',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى إدخال الاسم الكامل' : 'Please enter full name')
                      : null,
                ),
                const SizedBox(height: 14),

                // 2. Company Name
                AppTextField(
                  controller: _companyNameController,
                  label: l10n.translate('company_name'),
                  hint: l10n.isArabic ? 'أدخل اسم الشركة' : 'Enter company name',
                  prefixIcon: Icons.business,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? (l10n.isArabic ? 'يرجى إدخال اسم الشركة' : 'Please enter company name')
                      : null,
                ),
                const SizedBox(height: 14),

                // 3. Company Phone Number (Country Code Locked)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.isArabic ? 'رقم هاتف الشركة *' : 'Company Phone Number *',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.isArabic ? 'يرجى إدخال رقم الهاتف' : 'Please enter phone number';
                        }
                        final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
                        final expectedLen = activeCountry.id == 'kw' ? 8 : 9;
                        if (digits.length < expectedLen) {
                          return l10n.isArabic
                              ? 'يرجى إدخال $expectedLen أرقام لرقم الهاتف'
                              : 'Please enter $expectedLen digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: activeCountry.id == 'kw'
                            ? (l10n.isArabic ? 'أدخل 8 أرقام' : 'Enter 8 digits')
                            : (l10n.isArabic ? 'أدخل 9 أرقام' : 'Enter 9 digits'),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 12),
                            const Icon(Icons.phone_outlined, color: AppColors.textMuted, size: 20),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(activeCountry.flagEmoji, style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 4),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      activeCountry.phoneCode,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.lock_outline_rounded, size: 13, color: Color(0xFF64748B)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // 4. Email Address
                AppTextField(
                  controller: _emailController,
                  label: l10n.translate('email_address'),
                  hint: 'name@company.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? (l10n.isArabic ? 'يرجى إدخال بريد إلكتروني صحيح' : 'Please enter a valid email')
                      : null,
                ),
                const SizedBox(height: 14),

                // 4. Password
                AppTextField(
                  controller: _passwordController,
                  label: l10n.translate('password'),
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? (l10n.isArabic ? 'كلمة المرور يجب أن لا تقل عن 6 أحرف' : 'Password must be at least 6 characters')
                      : null,
                ),
                const SizedBox(height: 14),

                // 5. Confirm Password
                AppTextField(
                  controller: _confirmPasswordController,
                  label: l10n.translate('confirm_password'),
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return l10n.isArabic ? 'يرجى تأكيد كلمة المرور' : 'Please confirm password';
                    }
                    if (v != _passwordController.text) {
                      return l10n.isArabic ? 'كلمات المرور غير متطابقة' : 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                /*
                // Commercial License (To be added in next version)
                AppTextField(
                  controller: _licenseController,
                  label: l10n.translate('commercial_license'),
                  hint: l10n.isArabic ? 'رقم السجل التجاري الكويتي' : 'Kuwait Commercial License No.',
                  prefixIcon: Icons.badge_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),

                // Phone with Country Code Selector (Kuwait Only) (To be added in next version)
                AppTextField(
                  controller: _phoneController,
                  label: l10n.isArabic ? 'هاتف التواصل / واتساب الشركة في الكويت' : 'Company Phone / WhatsApp in Kuwait',
                  hint: '9XXXXXXX / 2XXXXXXX',
                  prefixWidget: _buildCountryCodeSelector(context, l10n),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 14),

                // Governorate (To be added in next version)
                Text(
                  l10n.isArabic ? 'المحافظة الرئيسية لمقر الشركة' : 'Headquarters Governorate in Kuwait',
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
                      value: KuwaitData.governorates.any((g) => g['name_ar'] == _selectedGovernorate)
                          ? _selectedGovernorate
                          : KuwaitData.governorates.first['name_ar'],
                      isExpanded: true,
                      items: KuwaitData.governorates.map((g) {
                        return DropdownMenuItem(
                          value: g['name_ar'],
                          child: Text(l10n.isArabic ? g['name_ar']! : g['name_en']!),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedGovernorate = val);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                */

                // Terms
                Row(
                  children: [
                    Checkbox(
                      value: _agreeTerms,
                      activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                    ),
                    Expanded(
                      child: Text(
                        l10n.isArabic
                            ? 'أوافق على الشروط والأحكام وسياسة الخصوصية'
                            : 'I agree to the Terms, Conditions and Privacy Policy',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Submit
                AppButton(
                  text: l10n.isArabic ? 'تسجيل حساب شركة جديد' : 'Register Company Account',
                  isLoading: authState.isLoading,
                  onPressed: () => _handleRegister(l10n),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryCodeSelector(BuildContext context, AppLocalizations l10n) {
    return InkWell(
      onTap: () => _showCountryPickerModal(context, l10n),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🇰🇼',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 6),
            const Text(
              '+965',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 24,
              color: AppColors.border,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  void _showCountryPickerModal(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.isArabic ? 'رمز الدولة (دولة الكويت)' : 'Country Code (Kuwait Only)',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Exclusive Kuwait banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_outlined, color: AppColors.primary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.isArabic
                              ? 'منصة دايركت وورك معتمدة رسمياً وتعمل حصرياً في دولة الكويت (+965).'
                              : 'Direct Work operates exclusively in the State of Kuwait (+965).',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.isArabic ? 'الدولة المعتمدة (مفعلة)' : 'Supported Country (Active)',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                // Kuwait (Selected and Active)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.primary, width: 1.6),
                  ),
                  child: ListTile(
                    leading: const Text('🇰🇼', style: TextStyle(fontSize: 28)),
                    title: Text(
                      l10n.isArabic ? 'دولة الكويت' : 'State of Kuwait',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      l10n.isArabic ? 'السوق المحلي الكويتي' : 'Kuwait Domestic Market',
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '+965',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.check_circle, color: AppColors.primary, size: 22),
                      ],
                    ),
                    onTap: () => Navigator.pop(ctx),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.isArabic ? 'دول أخرى (غير متاحة)' : 'Other Countries (Unavailable)',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: [
                      _buildDisabledCountryTile('🇸🇦', l10n.isArabic ? 'المملكة العربية السعودية' : 'Saudi Arabia', '+966', l10n),
                      _buildDisabledCountryTile('🇦🇪', l10n.isArabic ? 'الإمارات العربية المتحدة' : 'United Arab Emirates', '+971', l10n),
                      _buildDisabledCountryTile('🇶🇦', l10n.isArabic ? 'دولة قطر' : 'Qatar', '+974', l10n),
                      _buildDisabledCountryTile('🇧🇭', l10n.isArabic ? 'مملكة البحرين' : 'Bahrain', '+973', l10n),
                      _buildDisabledCountryTile('🇴🇲', l10n.isArabic ? 'سلطنة عمان' : 'Oman', '+968', l10n),
                      _buildDisabledCountryTile('🇪🇬', l10n.isArabic ? 'جمهورية مصر العربية' : 'Egypt', '+20', l10n),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDisabledCountryTile(String flag, String name, String code, AppLocalizations l10n) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(
        name,
        style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(code, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              l10n.isArabic ? 'غير متاح' : 'Not Allowed',
              style: const TextStyle(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.isArabic
                  ? 'منصة دايركت وورك مخصصة حصرياً لدولة الكويت (+965).'
                  : 'Direct Work is exclusive to the State of Kuwait (+965).',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

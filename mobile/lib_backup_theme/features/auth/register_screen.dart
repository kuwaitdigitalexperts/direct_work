import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final String role;
  const RegisterScreen({super.key, this.role = 'applicant'});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedCountryCode = '+965';
  String? _selectedNationality;
  String? _selectedCountryOfResidence;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;

  static const List<Map<String, String>> _countryCodes = [
    {'code': '+965', 'country': 'Kuwait', 'flag': '🇰🇼'},
    {'code': '+92', 'country': 'Pakistan', 'flag': '🇵🇰'},
    {'code': '+91', 'country': 'India', 'flag': '🇮🇳'},
    {'code': '+20', 'country': 'Egypt', 'flag': '🇪🇬'},
    {'code': '+966', 'country': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'code': '+63', 'country': 'Philippines', 'flag': '🇵🇭'},
    {'code': '+880', 'country': 'Bangladesh', 'flag': '🇧🇩'},
    {'code': '+971', 'country': 'United Arab Emirates', 'flag': '🇦🇪'},
    {'code': '+962', 'country': 'Jordan', 'flag': '🇯🇴'},
    {'code': '+961', 'country': 'Lebanon', 'flag': '🇱🇧'},
  ];

  static const List<String> _countriesList = [
    'Kuwait',
    'Pakistan',
    'India',
    'Egypt',
    'Saudi Arabia',
    'Philippines',
    'Bangladesh',
    'United Arab Emirates',
    'Qatar',
    'Bahrain',
    'Oman',
    'Jordan',
    'Lebanon',
    'Syria',
    'Nepal',
    'Sri Lanka',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showCountryCodePicker(AppLocalizations loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    loc['select_country'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _countryCodes.length,
                    itemBuilder: (c, i) {
                      final item = _countryCodes[i];
                      return ListTile(
                        leading: Text(item['flag']!, style: const TextStyle(fontSize: 22)),
                        title: Text(item['country']!),
                        trailing: Text(
                          item['code']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8)),
                        ),
                        onTap: () {
                          setState(() => _selectedCountryCode = item['code']!);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNationalityPicker(AppLocalizations loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    loc['nationality'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _countriesList.length,
                    itemBuilder: (c, i) {
                      final country = _countriesList[i];
                      return ListTile(
                        title: Text(country),
                        trailing: _selectedNationality == country
                            ? const Icon(Icons.check, color: Color(0xFF1D4ED8))
                            : null,
                        onTap: () {
                          setState(() => _selectedNationality = country);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCountryOfResidencePicker(AppLocalizations loc) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    loc['country_of_residence'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(height: 1),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _countriesList.length,
                    itemBuilder: (c, i) {
                      final country = _countriesList[i];
                      return ListTile(
                        title: Text(country),
                        trailing: _selectedCountryOfResidence == country
                            ? const Icon(Icons.check, color: Color(0xFF1D4ED8))
                            : null,
                        onTap: () {
                          setState(() => _selectedCountryOfResidence = country);
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRegister() async {
    final loc = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_selectedNationality == null || _selectedNationality!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.isArabic ? 'يرجى اختيار الجنسية' : 'Please select your nationality'),
        ),
      );
      return;
    }
    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.isArabic ? 'يرجى الموافقة على الشروط وسياسة الخصوصية' : 'Please agree to terms and privacy policy'),
        ),
      );
      return;
    }

    final fullPhone = '$_selectedCountryCode ${_phoneController.text.trim()}';
    final success = await ref.read(authProvider.notifier).registerApplicant(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: fullPhone,
      password: _passwordController.text,
      nationality: _selectedNationality,
      countryOfResidence: _selectedCountryOfResidence ?? 'Kuwait',
      governorate: 'محافظة العاصمة',
      profession: 'باحث عن عمل',
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.success,
          content: Text(loc.isArabic ? 'تم إنشاء الحساب بنجاح' : 'Account created successfully'),
        ),
      );
      context.go('/home');
    } else if (mounted) {
      final err = ref.read(authProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Text(err ?? (loc.isArabic ? 'فشل إنشاء الحساب' : 'Registration failed')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                // Title matching Screenshot 1
                Center(
                  child: Column(
                    children: [
                      Text(
                        loc['create_your_account'],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        loc['enter_all_required_info'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                if (authState.errorMessage != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
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

                // 1. Full Name Field
                _buildFieldLabel(loc['full_name']),
                const SizedBox(height: 6),
                _buildInputContainer(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: loc.isArabic ? 'أدخل الاسم الكامل' : 'Enter full name',
                      prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF94A3B8), size: 22),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? (loc.isArabic ? 'يرجى إدخال الاسم' : 'Please enter full name')
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Phone Number Field with Country Code Picker
                _buildFieldLabel(loc['phone_number']),
                const SizedBox(height: 6),
                _buildInputContainer(
                  child: Row(
                    children: [
                      // Prefix phone icon
                      const Padding(
                        padding: EdgeInsets.only(left: 14, right: 8),
                        child: Icon(Icons.phone_outlined, color: Color(0xFF94A3B8), size: 20),
                      ),

                      // Country Code Selector (e.g. +92 ▾)
                      InkWell(
                        onTap: () => _showCountryCodePicker(loc),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                _selectedCountryCode,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),
                      Container(width: 1, height: 24, color: const Color(0xFFE2E8F0)),
                      const SizedBox(width: 8),

                      // Phone Number Input
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: loc.isArabic ? 'رقم الهاتف' : 'Phone number',
                            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                          ),
                          validator: (v) => (v == null || v.trim().length < 6)
                              ? (loc.isArabic ? 'يرجى إدخال رقم هاتف صحيح' : 'Please enter a valid phone number')
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Email Address Field
                _buildFieldLabel(loc['email_address']),
                const SizedBox(height: 6),
                _buildInputContainer(
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: loc.isArabic ? 'name@example.com' : 'name@example.com',
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                      prefixIcon: const Icon(Icons.mail_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    validator: (v) {
                      if (v == null || !v.contains('@')) {
                        return loc.isArabic ? 'يرجى إدخال بريد إلكتروني صحيح' : 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Nationality Field (Dropdown)
                _buildFieldLabel(loc['nationality']),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () => _showNationalityPicker(loc),
                  borderRadius: BorderRadius.circular(16),
                  child: _buildInputContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.outlined_flag_rounded, color: Color(0xFF94A3B8), size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedNationality ?? (loc.isArabic ? 'اختر الجنسية' : 'Select Nationality'),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedNationality != null
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF94A3B8), size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 5. Country of Residence Field (Dropdown)
                _buildFieldLabel(loc['country_of_residence']),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () => _showCountryOfResidencePicker(loc),
                  borderRadius: BorderRadius.circular(16),
                  child: _buildInputContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedCountryOfResidence ?? loc['select_country'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedCountryOfResidence != null
                                    ? const Color(0xFF0F172A)
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF94A3B8), size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 6. Password Field
                _buildFieldLabel(loc['password']),
                const SizedBox(height: 6),
                _buildInputContainer(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: loc['enter_password'],
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: const Color(0xFF94A3B8),
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    validator: (v) => (v == null || v.length < 6)
                        ? (loc.isArabic ? 'كلمة المرور يجب أن لا تقل عن 6 أحرف' : 'Password must be at least 6 characters')
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // 7. Confirm Password Field
                _buildFieldLabel(loc['confirm_password']),
                const SizedBox(height: 6),
                _buildInputContainer(
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: loc['re_enter_password'],
                      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF94A3B8), size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: const Color(0xFF94A3B8),
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return loc.isArabic ? 'يرجى تأكيد كلمة المرور' : 'Please confirm your password';
                      }
                      if (v != _passwordController.text) {
                        return loc.isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 18),

                // 8. Terms & Privacy Checkbox matching Screenshot 2
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreeTerms,
                        activeColor: const Color(0xFF1D4ED8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) => setState(() => _agreeTerms = val ?? false),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
                          children: [
                            TextSpan(text: loc.isArabic ? 'أوافق على ' : 'I agree to the '),
                            TextSpan(
                              text: loc.isArabic ? 'شروط الاستخدام' : 'Terms of Use',
                              style: const TextStyle(
                                color: Color(0xFF1D4ED8),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () => context.push('/terms'),
                            ),
                            TextSpan(text: loc.isArabic ? ' و ' : ' and '),
                            TextSpan(
                              text: loc.isArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
                              style: const TextStyle(
                                color: Color(0xFF1D4ED8),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () => context.push('/privacy'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 9. Primary Action Button: Create Account
                Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1D4ED8).withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: authState.isLoading ? null : _handleRegister,
                    child: authState.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : Text(
                            loc['create_account'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // 10. Bottom Link: Already have an account? Log In
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                      children: [
                        TextSpan(
                          text: loc.isArabic ? 'لديك حساب بالفعل؟ ' : 'Already have an account? ',
                        ),
                        TextSpan(
                          text: loc.isArabic ? 'تسجيل الدخول' : 'Log In',
                          style: const TextStyle(
                            color: Color(0xFF1D4ED8),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => context.push('/login'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0F172A),
      ),
    );
  }

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cityCountryController;
  late final TextEditingController _aboutController;
  late final TextEditingController _experienceController;
  late final TextEditingController _skillsController;
  late final TextEditingController _linkedInController;
  late final TextEditingController _githubController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;

    final names = (user?.fullName ?? '').trim().split(' ');
    final firstName = names.isNotEmpty ? names.first : 'Kamil';
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    _jobTitleController = TextEditingController(text: user?.profession ?? '');
    _emailController = TextEditingController(text: user?.email ?? 'uzair8225@gmail.com');
    _phoneController = TextEditingController(text: user?.phone ?? '+923108300295');
    _cityCountryController = TextEditingController(text: user?.countryOfResidence ?? '');
    _aboutController = TextEditingController(text: user?.bio ?? '');
    _experienceController = TextEditingController(
      text: user?.experienceYears != null ? user!.experienceYears.toString() : '',
    );
    _skillsController = TextEditingController();
    _linkedInController = TextEditingController();
    _githubController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityCountryController.dispose();
    _aboutController.dispose();
    _experienceController.dispose();
    _skillsController.dispose();
    _linkedInController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);
    final loc = AppLocalizations.of(context);

    try {
      final user = ref.read(authProvider).user;
      final fullName = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'.trim();

      if (user != null) {
        final updatedUser = user.copyWith(
          fullName: fullName.isNotEmpty ? fullName : user.fullName,
          phone: _phoneController.text.trim(),
          profession: _jobTitleController.text.trim(),
          countryOfResidence: _cityCountryController.text.trim(),
          bio: _aboutController.text.trim(),
          experienceYears: int.tryParse(_experienceController.text.trim()),
        );
        ref.read(authProvider.notifier).setUser(updatedUser);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF16A34A),
            content: Text(
              loc.isArabic ? 'تم حفظ التعديلات بنجاح' : 'Profile updated successfully',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFDC2626),
            content: Text(e.toString()),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final user = ref.watch(authProvider).user;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Icon(
                isRtl ? Icons.chevron_right : Icons.chevron_left,
                color: const Color(0xFF0F172A),
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          loc.isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextButton(
              onPressed: _isSaving ? null : _saveChanges,
              child: _isSaving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    )
                  : Text(
                      loc.isArabic ? 'حفظ التعديلات' : 'Save changes',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Profile Photo with Orange Camera Badge
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                      ),
                      child: ClipOval(
                        child: user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty
                            ? Image.network(
                                user.avatarUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _buildAvatarPlaceholder(),
                              )
                            : _buildAvatarPlaceholder(),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  loc.isArabic ? 'صورة الملف الشخصي (اختياري)' : 'Profile photo (optional)',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. First Name & Last Name (Side by Side Row)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(loc.isArabic ? 'الاسم الأول' : 'First Name'),
                          const SizedBox(height: 6),
                          _buildTextField(
                            controller: _firstNameController,
                            hintText: loc.isArabic ? 'الاسم الأول' : 'First Name',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(loc.isArabic ? 'اسم العائلة' : 'Last Name'),
                          const SizedBox(height: 6),
                          _buildTextField(
                            controller: _lastNameController,
                            hintText: loc.isArabic ? 'اسم العائلة' : 'Last Name',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. Job Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'المسمى الوظيفي' : 'Job Title'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _jobTitleController,
                      hintText: loc.isArabic ? 'المسمى الوظيفي' : 'Job Title',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 4. Email (Disabled with "Email can't be edited" badge)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFieldLabel(loc.isArabic ? 'البريد الإلكتروني' : 'Email'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.lock_outline_rounded, size: 12, color: Color(0xFF64748B)),
                              const SizedBox(width: 4),
                              Text(
                                loc.isArabic ? 'لا يمكن تعديل البريد' : 'Email can\'t be edited',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _emailController,
                      enabled: false,
                      hintText: 'Email',
                      fillColor: const Color(0xFFF8FAFC),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 5. Phone number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'رقم الهاتف' : 'Phone number'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _phoneController,
                      hintText: loc.isArabic ? 'رقم الهاتف' : 'Phone number',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 6. City / Country
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'المدينة / الدولة' : 'City / Country'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _cityCountryController,
                      hintText: loc.isArabic ? 'المدينة / الدولة' : 'City / Country',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 7. About You (Multi-line)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'نبذة عنك' : 'About You'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _aboutController,
                      hintText: loc.isArabic ? 'أخبرنا عن نفسك...' : 'Tell us about yourself...',
                      maxLines: 4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 8. Years of Experience
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'سنوات الخبرة' : 'Years of Experience'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _experienceController,
                      hintText: loc.isArabic ? 'سنوات الخبرة' : 'Years of Experience',
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 9. Skills
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(loc.isArabic ? 'المهارات' : 'Skills'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _skillsController,
                      hintText: loc.isArabic ? 'المهارات (مفصولة بفواصل)' : 'Skills (comma separated)',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 10. LinkedIn
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('LinkedIn'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _linkedInController,
                      hintText: 'LinkedIn URL',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 11. GitHub
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('GitHub'),
                    const SizedBox(height: 6),
                    _buildTextField(
                      controller: _githubController,
                      hintText: 'GitHub URL',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool enabled = true,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    Color? fillColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 14.5,
          color: enabled ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.normal,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          filled: true,
          fillColor: fillColor ?? const Color(0xFFF8FAFC),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: const Color(0xFF0F172A),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white70, size: 52),
      ),
    );
  }
}
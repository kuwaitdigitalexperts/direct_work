import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';

class DeleteAccountScreen extends ConsumerStatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  ConsumerState<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends ConsumerState<DeleteAccountScreen> {
  final _passwordController = TextEditingController();
  final _confirmDeleteController = TextEditingController();

  bool _isDeleting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmDeleteController.dispose();
    super.dispose();
  }

  Future<void> _handleDelete() async {
    final loc = AppLocalizations.of(context);

    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Text(
            loc.isArabic ? 'يرجى إدخال كلمة المرور الحالية' : 'Please enter your current password',
          ),
        ),
      );
      return;
    }

    final confirmationText = _confirmDeleteController.text.trim().toUpperCase();
    if (confirmationText != 'DELETE' && confirmationText != 'حذف') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          content: Text(
            loc.isArabic ? 'يرجى كتابة "DELETE" للتأكيد' : 'Please type "DELETE" to confirm',
          ),
        ),
      );
      return;
    }

    setState(() => _isDeleting = true);

    try {
      await ref.read(authProvider.notifier).deleteAccount();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF16A34A),
            content: Text(
              loc.isArabic ? 'تم حذف الحساب بنجاح' : 'Account deleted successfully',
            ),
          ),
        );
        context.go('/account-selection');
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
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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
          loc.isArabic ? 'حذف الحساب' : 'Delete Account',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Red Warning Box (matching Screenshot)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDC2626), width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFDC2626),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        loc.isArabic
                            ? 'تحذير: لا يمكن التراجع عن هذا الإجراء!'
                            : 'Warning: This action cannot be undone!',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDC2626),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      loc.isArabic ? 'عند حذف حسابك:' : 'When you delete your account:',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildBulletPoint(
                      loc.isArabic
                          ? '• سيتم حذف جميع بياناتك الشخصية'
                          : '• All your personal data will be deleted',
                    ),
                    _buildBulletPoint(
                      loc.isArabic
                          ? '• سيتم حذف جميع إعلاناتك وطلباتك'
                          : '• All your ads and applications will be deleted',
                    ),
                    _buildBulletPoint(
                      loc.isArabic
                          ? '• سيتم حذف جميع المرفقات'
                          : '• All attachments will be deleted',
                    ),
                    _buildBulletPoint(
                      loc.isArabic
                          ? '• لن تتمكن من تسجيل الدخول مرة أخرى'
                          : '• You will not be able to log in again',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. Confirmation Input Card (matching Screenshot)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Password Field
                    _buildFieldLabel(loc.isArabic ? 'كلمة المرور الحالية' : 'Current Password'),
                    const SizedBox(height: 8),
                    _buildRedOutlineField(
                      controller: _passwordController,
                      hintText: loc.isArabic ? 'أدخل كلمة المرور الخاصة بك' : 'Enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                    ),
                    const SizedBox(height: 18),

                    // Confirm Word Field
                    _buildFieldLabel(
                      loc.isArabic ? 'اكتب "DELETE" للتأكيد' : 'Type "DELETE" to confirm',
                    ),
                    const SizedBox(height: 8),
                    _buildRedOutlineField(
                      controller: _confirmDeleteController,
                      hintText: 'DELETE',
                      prefixIcon: Icons.error_outline_rounded,
                    ),
                    const SizedBox(height: 22),

                    // Permanently Delete Button (Solid Red)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB91C1C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: _isDeleting ? null : _handleDelete,
                        child: _isDeleting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.delete_outline, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    loc.isArabic
                                        ? 'حذف حسابي بشكل نهائي'
                                        : 'Permanently Delete My Account',
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 3. Cancel and Go Back Button (Outlined Pill)
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF334155),
                    side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(
                    loc.isArabic ? 'إلغاء والعودة للخلف' : 'Cancel and go back',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.5,
          color: Color(0xFF334155),
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildRedOutlineField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
        fontSize: 14.5,
        color: Color(0xFF0F172A),
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: const Color(0xFFDC2626), size: 20),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF94A3B8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFB91C1C), width: 1.8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/country_provider.dart';
import '../../providers/locale_provider.dart';
import '../../shared/widgets/app_dialogs.dart';
import '../../shared/widgets/language_selector_sheet.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _jobNotifications = true;
  bool _messageNotifications = true;

  Future<void> _openTechnicalSupport() async {
    final uri = Uri.parse('https://wa.me/96566707126?text=${Uri.encodeComponent('Direct Work Kuwait Support')}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Support contact: +965 6670 7126')),
        );
      }
    }
  }

  void _confirmLogout(AppLocalizations loc) {
    AppDialogs.showLogoutDialog(
      context,
      onConfirm: () async {
        try {
          await ref.read(authProvider.notifier).logout();
        } catch (_) {}
        if (mounted) {
          context.go('/account-selection');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final user = ref.watch(authProvider).user;
    final currentCountry = ref.watch(countryProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final userEmail = (user?.email != null && user!.email.isNotEmpty)
        ? user.email
        : 'uzair8225@gmail.com';

    final userPhone = (user?.phone != null && user!.phone.isNotEmpty)
        ? user.phone
        : '+923108300295';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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
          loc['settings'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -----------------------------------------------------------
              // 1. Account Section
              // -----------------------------------------------------------
              _buildSectionHeader(loc.isArabic ? 'الحساب' : 'Account'),
              const SizedBox(height: 8),
              _buildCardContainer([
                _buildTile(
                  icon: Icons.lock_outline_rounded,
                  title: loc.isArabic ? 'كلمة المرور والأمان' : 'Password & Security',
                  subtitle: loc.isArabic ? 'كلمة المرور والأمان' : 'Password & Security',
                  onTap: () => context.push('/change-password'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.mail_outline_rounded,
                  title: loc.isArabic ? 'البريد الإلكتروني' : 'Email',
                  subtitle: userEmail,
                  onTap: () => context.push('/edit-profile'),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.phone_outlined,
                  title: loc.isArabic ? 'رقم الهاتف' : 'Mobile Number',
                  subtitle: userPhone,
                  onTap: () => context.push('/edit-profile'),
                ),
              ]),
              const SizedBox(height: 20),

              // -----------------------------------------------------------
              // 2. Notifications Section
              // -----------------------------------------------------------
              _buildSectionHeader(loc['notifications']),
              const SizedBox(height: 8),
              _buildCardContainer([
                _buildSwitchTile(
                  icon: Icons.notifications_none_rounded,
                  title: loc.isArabic ? 'إشعارات الوظائف' : 'Job Notifications',
                  value: _jobNotifications,
                  onChanged: (val) => setState(() => _jobNotifications = val),
                ),
                _buildDivider(),
                _buildSwitchTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: loc.isArabic ? 'إشعارات الرسائل' : 'Message Notifications',
                  value: _messageNotifications,
                  onChanged: (val) => setState(() => _messageNotifications = val),
                ),
              ]),
              const SizedBox(height: 20),

              // -----------------------------------------------------------
              // 3. Application Section
              // -----------------------------------------------------------
              _buildSectionHeader(loc.isArabic ? 'التطبيق' : 'Application'),
              const SizedBox(height: 8),
              _buildCardContainer([
                _buildTile(
                  icon: Icons.language_rounded,
                  title: loc['language'],
                  subtitle: '${loc.currentLanguage.flag} ${loc.currentLanguage.nativeName}',
                  onTap: () => LanguageSelectorSheet.show(context),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.public_rounded,
                  title: loc.isArabic ? 'الدولة / السوق' : 'Country / Market',
                  subtitle: '${currentCountry.flagEmoji} ${loc.isArabic ? currentCountry.nameAr : currentCountry.nameEn}',
                  onTap: () => context.push('/market-selection'),
                ),
              ]),
              const SizedBox(height: 20),

              // -----------------------------------------------------------
              // 4. Support & Help Section
              // -----------------------------------------------------------
              _buildSectionHeader(loc.isArabic ? 'الدعم والمساعدة' : 'Support & Help'),
              const SizedBox(height: 8),
              _buildCardContainer([
                _buildTile(
                  icon: Icons.phone_in_talk_outlined,
                  title: loc.isArabic ? 'اتصل بنا' : 'Contact Us',
                  subtitle: loc.isArabic ? 'الدعم الفني والاستفسارات.' : 'Technical support and inquiries.',
                  onTap: _openTechnicalSupport,
                ),
              ]),
              const SizedBox(height: 24),

              // -----------------------------------------------------------
              // 5. Logout Button (Red Outline Pill)
              // -----------------------------------------------------------
              InkWell(
                onTap: () => _confirmLogout(loc),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFDC2626),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        loc.isArabic ? 'تسجيل الخروج من هذا الجهاز' : 'Log out from this device',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDC2626),
                        ),
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF475569),
      ),
    );
  }

  Widget _buildCardContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isRtl ? Icons.chevron_left : Icons.chevron_right,
              color: const Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          Switch(
            value: value,
            activeColor: AppColors.primary,
            activeTrackColor: const Color(0xFFBFDBFE),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 68,
      endIndent: 16,
      color: Color(0xFFF1F5F9),
    );
  }
}
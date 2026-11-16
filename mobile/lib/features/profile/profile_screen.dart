import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/user_model.dart';
import '../../providers/applications_provider.dart';
import '../../providers/auth_provider.dart';
import '../../shared/widgets/app_dialogs.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final appState = ref.watch(applicationsProvider);
    final appsCount = appState.applications.length > 0 ? appState.applications.length : 1;

    final userName = (user?.fullName != null && user!.fullName.trim().isNotEmpty)
        ? user.fullName
        : (loc.isArabic ? 'كامل' : 'Kamil');

    final userProfession = (user?.profession != null && user!.profession!.trim().isNotEmpty)
        ? user.profession!
        : (loc.isArabic ? 'نجار تسليح (أعمدة وأسقف)' : 'Formwork Carpenter (Columns & Slabs)');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top App Bar matching Screenshot
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    // Circular Back Button
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
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

                    // Centered Title
                    Expanded(
                      child: Center(
                        child: Text(
                          loc['my_account'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),

                    // Circular Settings Button (Gear)
                    InkWell(
                      onTap: () => context.push('/settings'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Color(0xFF0F172A),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Profile Header (Avatar with orange circular border + Name & Profession)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                    ),
                    padding: const EdgeInsets.all(2),
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userProfession,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF64748B),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Middle Statistics Card (Applications count)
              InkWell(
                onTap: () => context.push('/my-applications'),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFBFDBFE), width: 1.2),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$appsCount',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc['applications_card'],
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 4. White Rounded Options Card matching Screenshot
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Item 1: Edit Profile
                    _buildMenuItemRow(
                      icon: Icons.person_outline_rounded,
                      title: loc['edit_profile'],
                      onTap: () => context.push('/edit-profile'),
                    ),
                    _buildDivider(),

                    // Item 2: Technical Support
                    _buildMenuItemRow(
                      icon: Icons.headset_mic_outlined,
                      title: loc['technical_support'],
                      onTap: _openTechnicalSupport,
                    ),
                    _buildDivider(),

                    // Item 3: Watch my Ads
                    _buildMenuItemRow(
                      icon: Icons.business_center_outlined,
                      title: loc['watch_my_ads'],
                      onTap: () => context.push('/my-ads'),
                    ),
                    _buildDivider(),

                    // Item 4: My Commercial Ads
                    _buildMenuItemRow(
                      icon: Icons.storefront_outlined,
                      title: loc['my_commercial_ads'],
                      onTap: () => context.push('/my-commercial-ads'),
                    ),
                    _buildDivider(),

                    // Item 5: Notifications
                    _buildMenuItemRow(
                      icon: Icons.notifications_none_outlined,
                      title: loc['notifications'],
                      onTap: () => context.push('/notifications'),
                    ),
                    _buildDivider(),

                    // Item 6: Settings
                    _buildMenuItemRow(
                      icon: Icons.settings_outlined,
                      title: loc['settings'],
                      onTap: () => context.push('/settings'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 5. Action Button 1: Delete Account Permanently (Red Outline Pill)
              InkWell(
                onTap: () => context.push('/delete-account'),
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
                        Icons.delete_outline,
                        color: Color(0xFFDC2626),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          loc['delete_account_permanently'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDC2626),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 6. Action Button 2: Log out (Red Tinted Pill)
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
                        loc['logout'],
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

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: const Color(0xFF0F172A),
      child: const Center(
        child: Icon(Icons.person, color: Colors.white70, size: 40),
      ),
    );
  }

  Widget _buildMenuItemRow({
    required IconData icon,
    required String title,
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
            // Circular soft blue icon container matching primary brand theme
            Container(
              width: 42,
              height: 42,
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

            // Item Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),

            // Trailing Chevron
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
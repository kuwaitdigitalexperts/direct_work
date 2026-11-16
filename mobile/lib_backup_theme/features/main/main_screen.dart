import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../chat/chat_list_screen.dart';
import '../commercial/commercial_screen.dart';
import '../home/home_screen.dart';
import '../jobs/jobs_screen.dart';
import '../jobs/company_search_screen.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../../shared/widgets/app_dialogs.dart';

class MainScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 3}); // Defaults to Home (Index 3)

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _showAddAdModal(BuildContext context, AppLocalizations l10n) {
    // Commented out modal content for current build; to be released in next build.
    // Displays "Available Soon" top notice matching commercial ads screen.
    /*
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.isArabic ? 'أضف إعلانك في المنصة' : 'Add Your Ad on Platform',
                      style: const TextStyle(
                        fontSize: 17,
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
                const SizedBox(height: 16),
                _buildModalOption(
                  icon: Icons.person_add_alt_1_outlined,
                  color: const Color(0xFFEA580C),
                  title: l10n.isArabic ? 'تقديم طلب توظيف (نشر إعلانك للشركات)' : 'Apply for Jobs (Post Your Candidate Ad)',
                  subtitle: l10n.isArabic ? 'اختر مهنتك وانضم لقاعدة بيانات الكفاءات' : 'Select your profession and reach top companies',
                  onTap: () {
                    Navigator.pop(ctx);
                    final user = ref.read(authProvider).user;
                    final isInsideKuwait = user != null && user.isInsideKuwait;
                    if (!isInsideKuwait) {
                      AppDialogs.showInsideApplicationNotice(context);
                    } else {
                      context.push('/select-sector?locationType=inside');
                    }
                  },
                ),
                const SizedBox(height: 10),
                _buildModalOption(
                  icon: Icons.work_outline,
                  color: AppColors.primary,
                  title: l10n.isArabic ? 'نشر إعلان وظيفة شاغرة' : 'Post a Job Vacancy',
                  subtitle: l10n.isArabic ? 'للشركات وأصحاب العمل لاستقطاب الكفاءات' : 'For employers to hire candidates directly',
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/post-job');
                  },
                ),
                const SizedBox(height: 10),
                _buildModalOption(
                  icon: Icons.home_repair_service_outlined,
                  color: AppColors.info,
                  title: l10n.isArabic ? 'نشر خدمة صيانة أو مهنية' : 'Post Maintenance / Repair Service',
                  subtitle: l10n.isArabic ? 'للفنيين والمهنيين للوصول لعملاء الكويت' : 'Reach thousands of clients across Kuwait',
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/create-service');
                  },
                ),
                const SizedBox(height: 10),
                _buildModalOption(
                  icon: Icons.campaign_outlined,
                  color: AppColors.partTimePurple,
                  title: l10n.isArabic ? 'نشر إعلان تجاري أو عروض شركات' : 'Post Commercial Company Ad',
                  subtitle: l10n.isArabic ? 'بانرات ترويجية وحملات تسويقية' : 'Promotional banners and business campaigns',
                  onTap: () {
                    Navigator.pop(ctx);
                    AppDialogs.showAvailableSoonTopNotice(context);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
    */

    AppDialogs.showAvailableSoonTopNotice(
      context,
      message: l10n.isArabic
          ? 'ميزة نشر الإعلانات ستكون متاحة قريباً في التحديث القادم!'
          : 'The ad posting feature will be available soon in the upcoming update!',
    );
  }

  Widget _buildModalOption({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    final isCompany = authState.user?.role == UserRole.company;

    final screens = [
      const ChatListScreen(),                                                    // Index 0: Chats
      isCompany
          ? CompanySearchScreen(onBack: () => setState(() => _currentIndex = 3))
          : const JobsScreen(),                                                  // Index 1: Search / Jobs
      const CommercialScreen(),                                                  // Index 2: Commercial
      HomeScreen(onNavigateTab: (index) => setState(() => _currentIndex = index)), // Index 3: Home
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // 1. Chats Tab
                _buildNavItem(
                  index: 0,
                  icon: Icons.chat_bubble_outline_rounded,
                  activeIcon: Icons.chat_bubble_rounded,
                  label: l10n.translate('tab_chats'),
                  isSelected: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),

                // 2. Search Tab
                _buildNavItem(
                  index: 1,
                  icon: Icons.search_rounded,
                  activeIcon: Icons.search_rounded,
                  label: l10n.translate('tab_search'),
                  isSelected: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                ),

                // 3. Center Elevated "Add your ad" Button (Exact Reference Match)
                _buildCenterAddButton(
                  label: l10n.translate('tab_add_ad'),
                  onTap: () => _showAddAdModal(context, l10n),
                ),

                // 4. Commercial Tab
                _buildNavItem(
                  index: 2,
                  icon: Icons.campaign_outlined,
                  activeIcon: Icons.campaign_rounded,
                  label: l10n.translate('tab_commercial'),
                  isSelected: _currentIndex == 2,
                  onTap: () => setState(() => _currentIndex = 2),
                ),

                // 5. Home Tab
                _buildNavItem(
                  index: 3,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: l10n.translate('tab_home'),
                  isSelected: _currentIndex == 3,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 24,
              color: isSelected ? AppColors.primary : const Color(0xFF64748B),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : const Color(0xFF64748B),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 2),
            // Tiny Active Indicator Dot (Matches Images 1, 2, 3)
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterAddButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Transform.translate(
          offset: const Offset(0, -10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.38),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

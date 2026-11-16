import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/countries_data.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/country_config.dart';
import '../../providers/country_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../shared/widgets/job_card.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import 'company_search_screen.dart';
import 'apply_job_sheet.dart';
import '../../shared/widgets/app_dialogs.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showGovernorateModal(AppLocalizations l10n) {
    final currentGov = ref.read(jobsProvider).selectedGovernorate;
    final activeCountry = ref.read(countryProvider);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  l10n.isArabic
                      ? 'اختر المنطقة / المحافظة (${activeCountry.nameAr})'
                      : 'Select Region / Area (${activeCountry.nameEn})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(l10n.isArabic ? 'كافة المناطق' : 'All Regions'),
                trailing: currentGov == 'all'
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  ref.read(jobsProvider.notifier).setGovernorate('all');
                  Navigator.pop(ctx);
                },
              ),
              ...activeCountry.regions.map((g) {
                final isSelected = currentGov == g['id'];
                return ListTile(
                  title: Text(l10n.isArabic ? g['name_ar']! : g['name_en']!),
                  subtitle: Text(l10n.isArabic ? g['name_en']! : g['name_ar']!),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    ref.read(jobsProvider.notifier).setGovernorate(g['id']!);
                    Navigator.pop(ctx);
                  },
                );
              }),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _openApplySheet(String jobId, String jobTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => ApplyJobSheet(jobId: jobId, jobTitle: jobTitle),
    );
  }

  void _showPostAdModal(BuildContext context, AppLocalizations l10n) {
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
                Text(
                  l10n.isArabic ? 'أعلن معنا في منصة دايركت وورك الكويت' : 'Advertise with Direct work Kuwait',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildModalActionTile(
                  icon: Icons.work_outline,
                  color: AppColors.primary,
                  title: l10n.isArabic ? 'نشر إعلان وظيفة شاغرة لشركتك' : 'Post a Job Vacancy for Employers',
                  subtitle: l10n.isArabic ? 'استقطب الكفاءات وتواصل مع المتقدمين مباشرة' : 'Directly hire certified candidates',
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/post-job');
                  },
                ),
                const SizedBox(height: 10),
                _buildModalActionTile(
                  icon: Icons.home_repair_service_outlined,
                  color: AppColors.info,
                  title: l10n.isArabic ? 'نشر خدمة صيانة أو مهنية' : 'Post Maintenance / Repair Service',
                  subtitle: l10n.isArabic ? 'اعرض خدماتك لعملاء الكويت في سوق الخدمات' : 'Reach thousands of Kuwait clients',
                  onTap: () {
                    Navigator.pop(ctx);
                    context.push('/create-service');
                  },
                ),
                const SizedBox(height: 10),
                _buildModalActionTile(
                  icon: Icons.campaign_outlined,
                  color: AppColors.partTimePurple,
                  title: l10n.isArabic ? 'نشر إعلان تجاري أو عروض شركات' : 'Post Commercial Company Ad',
                  subtitle: l10n.isArabic ? 'بانرات ترويجية وحملات تسويقية' : 'Promotional banners and campaigns',
                  onTap: () {
                    Navigator.pop(ctx);
                    AppDialogs.showAvailableSoonTopNotice(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalActionTile({
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
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
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
    final authState = ref.watch(authProvider);
    if (authState.user?.role == UserRole.company) {
      return const CompanySearchScreen();
    }

    final l10n = AppLocalizations.of(context);
    final jobsState = ref.watch(jobsProvider);
    final activeCountry = ref.watch(countryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(jobsProvider.notifier).fetchJobs(),
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              // Kuwait Header & Search App Bar
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  color: AppColors.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: App Logo, Country Badge, Notification Icon
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 38,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.work, color: AppColors.primary, size: 22),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.translate('direct_work_title'),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  l10n.isArabic
                                      ? 'منصة التوظيف المباشر في ${activeCountry.nameAr}'
                                      : 'Direct Hiring Platform in ${activeCountry.nameEn}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Post Job / Ad Button (Commented out as requested for next build release)
                          /*
                          ElevatedButton.icon(
                            onPressed: () => _showPostAdModal(context, l10n),
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(l10n.translate('post_ad_btn')),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              minimumSize: const Size(0, 34),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          */
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Search Input
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            ref.read(jobsProvider.notifier).setSearchQuery(val);
                          },
                          decoration: InputDecoration(
                            hintText: l10n.translate('search_jobs_hint'),
                            prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () {
                                      _searchController.clear();
                                      ref.read(jobsProvider.notifier).setSearchQuery('');
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Location Filter Pill
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () => _showGovernorateModal(l10n),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.location_on, size: 14, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        _getGovernorateLabel(jobsState.selectedGovernorate, l10n),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryDark,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.primary),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (jobsState.selectedSector != 'all' ||
                              jobsState.selectedGovernorate != 'all' ||
                              jobsState.selectedWorkType != 'all' ||
                              jobsState.searchQuery.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {
                                _searchController.clear();
                                ref.read(jobsProvider.notifier).resetFilters();
                              },
                              icon: const Icon(Icons.refresh, size: 14, color: AppColors.error),
                              label: Text(
                                l10n.translate('reset_filter'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Sectors Horizontal Chips
              SliverToBoxAdapter(
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildSectorChip(
                        code: 'all',
                        name: l10n.translate('all_sectors'),
                        isSelected: jobsState.selectedSector == 'all',
                      ),
                      ...KuwaitData.sectors.map((s) {
                        return _buildSectorChip(
                          code: s['code'],
                          name: l10n.isArabic ? s['name_ar'] : s['name_en'],
                          isSelected: jobsState.selectedSector == s['code'],
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Work Type Chips Filter (Full Time / Part Time in Kuwait)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildWorkTypeChip(
                          id: 'all',
                          label: l10n.translate('all_types'),
                          isSelected: jobsState.selectedWorkType == 'all',
                        ),
                        const SizedBox(width: 8),
                        _buildWorkTypeChip(
                          id: 'full_time',
                          label: l10n.translate('full_time'),
                          isSelected: jobsState.selectedWorkType == 'full_time',
                        ),
                        const SizedBox(width: 8),
                        _buildWorkTypeChip(
                          id: 'part_time',
                          label: l10n.translate('part_time_kuwait'),
                          isSelected: jobsState.selectedWorkType == 'part_time',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Jobs Feed Section Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          l10n.translate('latest_jobs'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${jobsState.jobs.length} ${l10n.translate('jobs_available')}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Jobs List, Loading Skeletons, or Rich Empty State
              if (jobsState.isLoading && jobsState.jobs.isEmpty)
                SliverToBoxAdapter(
                  child: _buildLoadingSkeleton(),
                )
              else if (jobsState.jobs.isEmpty)
                SliverToBoxAdapter(
                  child: _buildEmptyState(context, jobsState, l10n, activeCountry),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final job = jobsState.jobs[index];
                        return JobCard(
                          job: job,
                          onTap: () => context.push('/jobs/${job.id}'),
                          onApply: () => _openApplySheet(job.id, job.title),
                        );
                      },
                      childCount: jobsState.jobs.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 160, height: 14, color: AppColors.surfaceVariant),
                          const SizedBox(height: 8),
                          Container(width: 100, height: 10, color: AppColors.surfaceVariant),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(width: double.infinity, height: 12, color: AppColors.surfaceVariant),
                const SizedBox(height: 6),
                Container(width: 200, height: 12, color: AppColors.surfaceVariant),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, JobsFilterState state, AppLocalizations l10n, CountryConfig activeCountry) {
    final govLabel = _getGovernorateLabel(state.selectedGovernorate, l10n);
    final sectorLabel = _getSectorLabel(state.selectedSector, l10n);
    final hasActiveFilter = state.selectedSector != 'all' ||
        state.selectedGovernorate != 'all' ||
        state.selectedWorkType != 'all' ||
        state.searchQuery.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Graphic Country Badge
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
            ),
            child: const Icon(
              Icons.work_history_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),

          // Country Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l10n.isArabic
                  ? 'سوق وظائف ${activeCountry.nameAr} ${activeCountry.flagEmoji}'
                  : '${activeCountry.nameEn} Job Market ${activeCountry.flagEmoji}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Main Headline
          Text(
            l10n.translate('no_jobs_found'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            l10n.translate('no_jobs_subtitle'),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),

          // Informative Context Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primarySubtle,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Text(
                  hasActiveFilter
                      ? (l10n.isArabic
                          ? 'لم نجد شواغر مطابقة في $govLabel لقطاع "$sectorLabel". يتم إضافة وظائف جديدة يومياً من الشركات في ${activeCountry.shortNameAr}.'
                          : 'No vacancies found in $govLabel for "$sectorLabel". Companies in ${activeCountry.shortNameEn} add new jobs daily.')
                      : (l10n.isArabic
                          ? 'لم يتم العثور على وظائف مطابقة لبحثك في الوقت الحالي داخل ${activeCountry.nameAr}. يمكنك تجربة كلمات بحث أخرى أو إزالة الفلاتر.'
                          : 'No vacancies match your search at this time in ${activeCountry.nameEn}. Try different search terms or reset filters.'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Primary Action: Reset Filters
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              onPressed: () {
                _searchController.clear();
                ref.read(jobsProvider.notifier).resetFilters();
              },
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(l10n.translate('show_all_jobs_btn')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Secondary Action: Post a Vacancy (Employer)
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: () => context.push('/post-job'),
              icon: const Icon(Icons.add_business_outlined, size: 18),
              label: Text(l10n.translate('post_job_company_btn')),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryDark,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Suggested Sectors Shortcuts
          Align(
            alignment: l10n.isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              l10n.translate('browse_popular_sectors'),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildSuggestedSectorChip('technical', l10n.isArabic ? '🔧 فنيون وصيانة' : '🔧 Tech & Maintenance'),
              _buildSuggestedSectorChip('drivers', l10n.isArabic ? '🚗 سائقون وتوصيل' : '🚗 Drivers & Logistics'),
              _buildSuggestedSectorChip('restaurants', l10n.isArabic ? '☕ مطاعم وضيافة' : '☕ Hospitality & Dining'),
              _buildSuggestedSectorChip('engineering', l10n.isArabic ? '🏗️ هندسة ومقاولات' : '🏗️ Engineering'),
              _buildSuggestedSectorChip('beauty', l10n.isArabic ? '💇 صالونات وتجميل' : '💇 Salons & Beauty'),
              _buildSuggestedSectorChip('sales', l10n.isArabic ? '💼 مبيعات وإدارة' : '💼 Sales & Management'),
            ],
          ),
          const SizedBox(height: 20),

          // Direct WhatsApp Contact Support
          InkWell(
            onTap: () => _launchSupportWhatsApp(l10n),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF25D366),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat, size: 14, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      l10n.translate('whatsapp_inquiry_link'),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedSectorChip(String code, String label) {
    return ActionChip(
      label: Text(label),
      labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryDark),
      backgroundColor: AppColors.primaryLight,
      side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        _searchController.clear();
        ref.read(jobsProvider.notifier).setSector(code);
      },
    );
  }

  Future<void> _launchSupportWhatsApp(AppLocalizations l10n) async {
    final msg = l10n.isArabic
        ? 'مرحباً، أود الاستفسار عن إعلانات الوظائف في دايركت وورك الكويت'
        : 'Hello, I would like to inquire about job ads on Direct Work Kuwait';
    final uri = Uri.parse('https://wa.me/96566707126?text=${Uri.encodeComponent(msg)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildSectorChip({
    required String code,
    required String name,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(name),
        selected: isSelected,
        onSelected: (_) => ref.read(jobsProvider.notifier).setSector(code),
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surface,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildWorkTypeChip({
    required String id,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => ref.read(jobsProvider.notifier).setWorkType(id),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  String _getGovernorateLabel(String id, AppLocalizations l10n) {
    if (id == 'all') return l10n.isArabic ? 'كافة المناطق' : 'All Areas';
    final activeCountry = ref.read(countryProvider);
    for (final g in activeCountry.regions) {
      if (g['id'] == id) {
        return (l10n.isArabic ? g['name_ar'] : g['name_en']) ?? id;
      }
    }
    for (final c in CountriesData.allCountries) {
      for (final g in c.regions) {
        if (g['id'] == id) {
          return (l10n.isArabic ? g['name_ar'] : g['name_en']) ?? id;
        }
      }
    }
    return id;
  }

  String _getSectorLabel(String code, AppLocalizations l10n) {
    if (code == 'all') return l10n.translate('all_sectors');
    final sec = KuwaitData.sectors.firstWhere(
      (s) => s['code'] == code,
      orElse: () => {'name_ar': 'القطاع المختار', 'name_en': 'Selected Sector'},
    );
    return (l10n.isArabic ? sec['name_ar'] : sec['name_en']) ?? '';
  }
}

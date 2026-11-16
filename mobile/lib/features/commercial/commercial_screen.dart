import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../shared/widgets/app_dialogs.dart';

class CommercialScreen extends ConsumerStatefulWidget {
  const CommercialScreen({super.key});

  @override
  ConsumerState<CommercialScreen> createState() => _CommercialScreenState();
}

class _CommercialScreenState extends ConsumerState<CommercialScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.translate('commercial_title'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              l10n.isArabic
                  ? 'تصفح وأضف إعلانات وبانرات الشركات'
                  : 'Browse or post commercial banners',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business_outlined, color: AppColors.primary),
            tooltip: l10n.translate('post_commercial'),
            onPressed: () => AppDialogs.showAvailableSoonTopNotice(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Realistic Background Feed (Screenshot 3 Backdrop)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar Placeholder
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                        const SizedBox(width: 10),
                        Text(
                          l10n.isArabic ? 'البحث في الإعلانات...' : 'Search ads...',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Category Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip(l10n.isArabic ? 'الكل' : 'All', true),
                        const SizedBox(width: 8),
                        _buildCategoryChip(l10n.isArabic ? 'مطاعم وكافيهات' : 'Restaurants & Cafes', false),
                        const SizedBox(width: 8),
                        _buildCategoryChip(l10n.isArabic ? 'موضة وأزياء' : 'Fashion & Retail', false),
                        const SizedBox(width: 8),
                        _buildCategoryChip(l10n.isArabic ? 'إلكترونيات' : 'Electronics', false),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Semi-transparent overlay backdrop
            Container(
              color: Colors.black.withOpacity(0.06),
            ),

            // Center Modal Lock Card matching Screenshot 3
            AppDialogs.buildAvailableSoonCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : const Color(0xFF64748B),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }
}

/*
// ============================================================================
// COMMERCIAL ADS FEATURE - DEFERRED TO NEXT VERSION
// The full implementation below is preserved and commented for future release.
// ============================================================================

/*
class _FullCommercialScreenState extends ConsumerState<CommercialScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final commercialState = ref.watch(commercialProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.translate('commercial_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business_outlined, color: AppColors.primary),
            tooltip: l10n.translate('post_commercial'),
            onPressed: () => context.push('/create-commercial'),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(commercialProvider.notifier).fetchAds(),
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) {
                            ref.read(commercialProvider.notifier).setSearch(val);
                          },
                          decoration: InputDecoration(
                            hintText: l10n.translate('search_commercial_hint'),
                            prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              if (commercialState.isLoading && commercialState.ads.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),
                  ),
                )
              else if (commercialState.ads.isEmpty)
                SliverToBoxAdapter(
                  child: _buildEmptyCommercialView(context),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final ad = commercialState.ads[index];
                        return CommercialBanner(
                          ad: ad,
                          onTap: () {},
                        );
                      },
                      childCount: commercialState.ads.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
*/

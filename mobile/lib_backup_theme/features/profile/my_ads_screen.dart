import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/jobs_provider.dart';

class MyAdsScreen extends ConsumerStatefulWidget {
  const MyAdsScreen({super.key});

  @override
  ConsumerState<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends ConsumerState<MyAdsScreen> {
  String _selectedFilter = 'all'; // 'all', 'active', 'pending', 'expired'

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final user = ref.watch(authProvider).user;

    final adTitle = (user?.profession != null && user!.profession!.isNotEmpty)
        ? user.profession!
        : (loc.isArabic ? 'نجار تسليح (أعمدة وأسقف)' : 'Formwork Carpenter (Columns & Slabs)');

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
          loc.isArabic ? 'متابعة إعلاناتي' : 'Watch my Ads',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle under App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                loc.isArabic
                    ? 'راجع إعلاناتك، عدلها، وجدد مدة ظهورها من هنا.'
                    : 'Review, edit, and renew your ad duration here.',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Filter Pills Row matching Screenshot
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterPill(
                    id: 'all',
                    icon: Icons.layers_outlined,
                    label: loc.isArabic ? 'الكل' : 'All',
                  ),
                  const SizedBox(width: 8),
                  _buildFilterPill(
                    id: 'active',
                    icon: Icons.check_circle_outline_rounded,
                    label: loc.isArabic ? 'نشط' : 'Active',
                  ),
                  const SizedBox(width: 8),
                  _buildFilterPill(
                    id: 'pending',
                    icon: Icons.access_time_rounded,
                    label: loc.isArabic ? 'قيد الانتظار' : 'Pending',
                  ),
                  const SizedBox(width: 8),
                  _buildFilterPill(
                    id: 'expired',
                    icon: Icons.highlight_off_rounded,
                    label: loc.isArabic ? 'منتهي' : 'Expired',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Main Card or List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_selectedFilter == 'all' || _selectedFilter == 'pending') ...[
                    _buildAdCard(
                      title: adTitle,
                      sector: loc.isArabic ? 'قطاع البناء والتشييد' : 'Construction Sector',
                      status: loc.isArabic ? 'بانتظار الدفع' : 'Pending payment',
                      statusNotice: loc.isArabic
                          ? 'بانتظار الدفع. أكمل الدفع لتفعيل إعلانك.'
                          : 'Payment pending. Complete payment to activate your ad.',
                      appliedDate: '2026-11-12',
                      expiresDate: '-',
                      imagesCount: 1,
                      docsCount: 1,
                      bookmarksCount: 0,
                      linksCount: 2,
                      viewsCount: 0,
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          loc.isArabic ? 'لا توجد إعلانات في هذا القسم' : 'No ads in this category',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      loc.isArabic ? 'لا توجد نتائج أخرى' : 'No more results',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill({
    required String id,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedFilter == id;

    return InkWell(
      onTap: () => setState(() => _selectedFilter = id),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdCard({
    required String title,
    required String sector,
    required String status,
    required String statusNotice,
    required String appliedDate,
    required String expiresDate,
    required int imagesCount,
    required int docsCount,
    required int bookmarksCount,
    required int linksCount,
    required int viewsCount,
  }) {
    final loc = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFDBFE), width: 1.2),
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
          // Top Row: Square placeholder + Title & Sector + Status Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Square placeholder icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.business_center_outlined,
                  color: Color(0xFF94A3B8),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),

              // Title and Sector
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      sector,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Status Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Status Notice
          Text(
            statusNotice,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Applied At & Expires On
          Row(
            children: [
              Expanded(
                child: Text(
                  '${loc.isArabic ? 'تاريخ التقديم' : 'Applied At'} $appliedDate',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              Text(
                '${loc.isArabic ? 'ينتهي في' : 'Expires On'} $expiresDate',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Counter Badges Row
          Row(
            children: [
              _buildCounterItem(Icons.image_outlined, imagesCount),
              const SizedBox(width: 8),
              _buildCounterItem(Icons.description_outlined, docsCount),
              const SizedBox(width: 8),
              _buildCounterItem(Icons.bookmark_border_rounded, bookmarksCount),
              const SizedBox(width: 8),
              _buildCounterItem(Icons.attach_file_rounded, linksCount),
            ],
          ),
          const SizedBox(height: 14),

          // Bottom Row: Views Pill + View > Link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$viewsCount ${loc.isArabic ? 'مشاهدة' : 'views'}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.push('/pricing-plans');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      loc.isArabic ? 'عرض' : 'View',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterItem(IconData icon, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
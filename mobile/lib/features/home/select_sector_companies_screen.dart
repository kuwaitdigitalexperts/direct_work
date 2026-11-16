import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/jobs_provider.dart';

class SelectSectorCompaniesScreen extends ConsumerStatefulWidget {
  final String locationType;

  const SelectSectorCompaniesScreen({
    super.key,
    this.locationType = 'inside',
  });

  @override
  ConsumerState<SelectSectorCompaniesScreen> createState() => _SelectSectorCompaniesScreenState();
}

class _SelectSectorCompaniesScreenState extends ConsumerState<SelectSectorCompaniesScreen> {
  String _selectedSectorCode = 'all';

  List<Map<String, dynamic>> get _sectorsData {
    final colors = [
      const Color(0xFFF59E0B),
      const Color(0xFFEA580C),
      const Color(0xFFEF4444),
      const Color(0xFFD97706),
      const Color(0xFF0284C7),
      const Color(0xFF7C3AED),
      const Color(0xFF10B981),
      const Color(0xFF2563EB),
      const Color(0xFF059669),
      const Color(0xFFDC2626),
      const Color(0xFFDB2777),
      const Color(0xFF4F46E5),
      const Color(0xFF0891B2),
      const Color(0xFF9333EA),
      const Color(0xFFCA8A04),
      const Color(0xFF65A30D),
      const Color(0xFF475569),
      const Color(0xFFE11D48),
      const Color(0xFF0D9488),
      const Color(0xFF6366F1),
      const Color(0xFF16A34A),
      const Color(0xFF78350F),
      const Color(0xFFB45309),
      const Color(0xFF1E293B),
      const Color(0xFF0284C7),
      const Color(0xFF0F766E),
      const Color(0xFFBE185D),
    ];
    return KuwaitData.jobSeekerSectors.asMap().entries.map((entry) {
      final idx = entry.key;
      final s = entry.value;
      return {
        'code': s['code'],
        'titleKey': 'sector_${s['code']}',
        'fallbackTitle': s['name_en'],
        'name_ar': s['name_ar'],
        'name_en': s['name_en'],
        'image': s['image'] ?? 'assets/images/sector_construction.jpg',
        'accentColor': colors[idx % colors.length],
      };
    }).toList();
  }

  void _onSelectSector(String sectorCode, String sectorTitle) {
    ref.read(jobsProvider.notifier).setSector(sectorCode);
    context.push(
      Uri(
        path: '/sector-applicants',
        queryParameters: {
          'sector': sectorCode,
          'sectorTitle': sectorTitle,
          'locationType': widget.locationType,
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;

    final filteredSectors = _selectedSectorCode == 'all'
        ? _sectorsData
        : _sectorsData.where((s) => s['code'] == _selectedSectorCode).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.maybePop(context),
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF334155)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Header Titles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.translate('select_sector_companies_title'),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.translate('select_sector_companies_desc'),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Section Label "Available Sectors"
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Align(
                alignment: isArabic ? Alignment.centerRight : Alignment.centerRight,
                child: Text(
                  l10n.translate('available_sectors_heading'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            // Horizontal Sector Filter Pills (Exact Image 3 Layout)
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterPill(
                    label: isArabic ? 'الكل' : 'All',
                    isSelected: _selectedSectorCode == 'all',
                    onTap: () => setState(() => _selectedSectorCode = 'all'),
                  ),
                  const SizedBox(width: 8),
                  ..._sectorsData.map((s) {
                    final translated = l10n.translate(s['titleKey'] as String);
                    final label = (translated != s['titleKey'] && translated.isNotEmpty)
                        ? translated
                        : (isArabic ? s['name_ar'] as String : s['name_en'] as String);
                    final isSelected = _selectedSectorCode == s['code'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildFilterPill(
                        label: label,
                        isSelected: isSelected,
                        onTap: () => setState(() => _selectedSectorCode = s['code'] as String),
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Large Graphic Sector Cards Feed
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                itemCount: filteredSectors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final sector = filteredSectors[index];
                  final translated = l10n.translate(sector['titleKey'] as String);
                  final title = (translated != sector['titleKey'] && translated.isNotEmpty)
                      ? translated
                      : (isArabic ? sector['name_ar'] as String : sector['name_en'] as String);
                  return _buildSectorCard(
                    title: title,
                    imageAsset: sector['image'] as String,
                    accentColor: sector['accentColor'] as Color,
                    onTap: () => _onSelectSector(sector['code'] as String, title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFCBD5E1),
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectorCard({
    required String title,
    required String imageAsset,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Sector Photographic Image
              Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primaryLight,
                  child: Center(
                    child: Icon(Icons.business_center, color: AppColors.primary, size: 40),
                  ),
                ),
              ),

              // Subtle tap highlight overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

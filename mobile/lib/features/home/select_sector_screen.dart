import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';

class SelectSectorScreen extends ConsumerStatefulWidget {
  final String locationType; // 'inside' or 'outside'

  const SelectSectorScreen({
    super.key,
    this.locationType = 'inside',
  });

  @override
  ConsumerState<SelectSectorScreen> createState() => _SelectSectorScreenState();
}

class _SelectSectorScreenState extends ConsumerState<SelectSectorScreen> {
  String _selectedCategoryCode = 'all';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;
    final isInside = widget.locationType == 'inside';

    final sectors = KuwaitData.jobSeekerSectors;
    final filteredSectors = _selectedCategoryCode == 'all'
        ? sectors
        : sectors.where((s) => s['code'] == _selectedCategoryCode).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
            ),
            child: IconButton(
              icon: Icon(
                isArabic ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
                size: 16,
                color: AppColors.textPrimary,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              l10n.translate('select_a_sector'),
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.locationType == 'part_time'
                  ? (isArabic ? 'دوام جزئي داخل الكويت (بتصريح مؤقت)' : 'Part-Time (Temporary work permit)')
                  : (isInside
                      ? l10n.translate('inside_kuwait')
                      : l10n.translate('outside_kuwait_subtitle')),
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Text(
              l10n.translate('available_sectors'),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Category Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip(
                    label: isArabic ? 'الكل' : 'All',
                    isSelected: _selectedCategoryCode == 'all',
                    onTap: () => setState(() => _selectedCategoryCode = 'all'),
                  ),
                  const SizedBox(width: 8),
                  ...sectors.map((s) {
                    final isSel = _selectedCategoryCode == s['code'];
                    final name = isArabic ? s['name_ar'] : s['name_en'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: _buildCategoryChip(
                        label: name,
                        isSelected: isSel,
                        onTap: () => setState(() => _selectedCategoryCode = s['code']),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Sector Big Graphic Cards
            ...filteredSectors.map((sector) {
              final title = isArabic ? sector['name_ar'] : sector['name_en'];
              return Row(
                children: [
                  _buildSectorCard(
                    title: title,
                    imagePath: sector['image'],
                    onTap: () {
                      context.push(
                        Uri(
                          path: '/sector-professions',
                          queryParameters: {
                            'sectorCode': sector['code'],
                            'sectorTitle': title,
                            'locationType': widget.locationType,
                          },
                        ).toString(),
                      );
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: isSelected ? AppColors.primaryGlow : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF334155),
          ),
        ),
      ),
    );
  }

  Widget _buildSectorCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 132,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppColors.softShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child:
            // Stack(
            //   fit: StackFit.expand,
            //   children: [
                // Background Image
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),

                // Gradient Overlay
                // Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Colors.black.withOpacity(0.4),
                //         Colors.transparent,
                //       ],
                //       begin: Alignment.centerLeft,
                //       end: Alignment.centerRight,
                //     ),
                //   ),
                // ),

                // Title Text
                // Positioned(
                //   left: 20,
                //   top: 0,
                //   bottom: 0,
                //   child: Center(
                //     child: SizedBox(
                //       width: 170,
                //       child: Text(
                //         title,
                //         style: const TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //           shadows: [
                //             Shadow(
                //               color: Colors.black54,
                //               blurRadius: 4,
                //               offset: Offset(0, 1),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

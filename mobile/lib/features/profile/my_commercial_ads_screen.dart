import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';

class MyCommercialAdsScreen extends ConsumerStatefulWidget {
  const MyCommercialAdsScreen({super.key});

  @override
  ConsumerState<MyCommercialAdsScreen> createState() => _MyCommercialAdsScreenState();
}

class _MyCommercialAdsScreenState extends ConsumerState<MyCommercialAdsScreen> {
  String _selectedFilter = 'all'; // 'all', 'active', 'pending', 'expired'

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
          loc['my_commercial_ads'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => context.push('/create-commercial'),
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
                  Icons.add,
                  color: Color(0xFF0F172A),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Horizontal Filter Pills Row matching Screenshot
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterPill(
                    id: 'all',
                    label: loc.isArabic ? 'الكل' : 'All',
                  ),
                  const SizedBox(width: 10),
                  _buildFilterPill(
                    id: 'active',
                    label: loc.isArabic ? 'نشط' : 'Active',
                  ),
                  const SizedBox(width: 10),
                  _buildFilterPill(
                    id: 'pending',
                    label: loc.isArabic ? 'قيد الانتظار' : 'Pending',
                  ),
                  const SizedBox(width: 10),
                  _buildFilterPill(
                    id: 'expired',
                    label: loc.isArabic ? 'منتهي' : 'Expired',
                  ),
                ],
              ),
            ),

            // Empty state matching Screenshot
            Expanded(
              child: Center(
                child: Text(
                  loc.isArabic ? 'لا توجد إعلانات تجارية حتى الآن' : 'No commercial ads yet',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill({
    required String id,
    required String label,
  }) {
    final isSelected = _selectedFilter == id;

    return InkWell(
      onTap: () => setState(() => _selectedFilter = id),
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.primary,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
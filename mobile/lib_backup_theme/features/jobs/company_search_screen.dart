import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/network/api_client.dart';

class SectorSearchItem {
  final String code;
  final String nameEn;
  final String nameAr;
  final int applicantsCount;

  const SectorSearchItem({
    required this.code,
    required this.nameEn,
    required this.nameAr,
    this.applicantsCount = 0,
  });

  String localizedName(bool isArabic) => isArabic ? nameAr : nameEn;

  factory SectorSearchItem.fromJson(Map<String, dynamic> json) {
    return SectorSearchItem(
      code: json['code'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      applicantsCount: json['applicants_count'] ?? 0,
    );
  }
}

class ProfessionSearchItem {
  final String id;
  final String nameEn;
  final String nameAr;
  final String sectorCode;
  final String sectorTitle;
  final int applicantsCount;

  const ProfessionSearchItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.sectorCode,
    required this.sectorTitle,
    this.applicantsCount = 0,
  });

  String localizedName(bool isArabic) => isArabic ? nameAr : nameEn;

  factory ProfessionSearchItem.fromJson(Map<String, dynamic> json) {
    return ProfessionSearchItem(
      id: json['id'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      sectorCode: json['sector_code'] ?? 'construction',
      sectorTitle: json['sector_title'] ?? 'Engineering & Construction',
      applicantsCount: json['applicants_count'] ?? 0,
    );
  }
}

class CompanySearchScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const CompanySearchScreen({
    super.key,
    this.onBack,
  });

  @override
  ConsumerState<CompanySearchScreen> createState() => _CompanySearchScreenState();
}

class _CompanySearchScreenState extends ConsumerState<CompanySearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  List<SectorSearchItem> _sectors = [];
  List<ProfessionSearchItem> _professions = [];
  bool _isLoading = false;

  static const List<SectorSearchItem> _defaultSectors = [
    SectorSearchItem(
      code: 'oil_gas',
      nameEn: 'Oil,Gas & Petrochemicals',
      nameAr: 'النفط والغاز والبتروكيماويات',
      applicantsCount: 14,
    ),
    SectorSearchItem(
      code: 'construction',
      nameEn: 'Engineering & Construction',
      nameAr: 'هندسة ومقاولات وإنشاءات',
      applicantsCount: 28,
    ),
    SectorSearchItem(
      code: 'medical',
      nameEn: 'Medical and Healthcare Sector',
      nameAr: 'رعاية صحية وطبية',
      applicantsCount: 19,
    ),
    SectorSearchItem(
      code: 'technical',
      nameEn: 'Technicians & Maintenance',
      nameAr: 'فنيون وصيانة',
      applicantsCount: 22,
    ),
    SectorSearchItem(
      code: 'drivers',
      nameEn: 'Drivers & Logistics',
      nameAr: 'سائقون وتوصيل ونقل',
      applicantsCount: 31,
    ),
    SectorSearchItem(
      code: 'restaurants',
      nameEn: 'Restaurants & Hospitality',
      nameAr: 'مطاعم وضيافة وفنادق',
      applicantsCount: 17,
    ),
    SectorSearchItem(
      code: 'sales',
      nameEn: 'Sales & Management',
      nameAr: 'مبيعات وإدارة ومحاسبة',
      applicantsCount: 25,
    ),
  ];

  static const List<ProfessionSearchItem> _defaultProfessions = [
    ProfessionSearchItem(
      id: 'prof_pharmacy',
      nameEn: 'Pharmacy Assistant',
      nameAr: 'مساعد صيدلي',
      sectorCode: 'medical',
      sectorTitle: 'Medical and Healthcare Sector',
      applicantsCount: 6,
    ),
    ProfessionSearchItem(
      id: 'prof_tailor',
      nameEn: 'Thobe/Dishdasha Tailor',
      nameAr: 'خياط دشاديش وثياب رجالية',
      sectorCode: 'technical',
      sectorTitle: 'Technicians & Maintenance',
      applicantsCount: 9,
    ),
    ProfessionSearchItem(
      id: 'prof_risk_assessor',
      nameEn: 'Property Risk Assessor',
      nameAr: 'مقيم مخاطر عقارية',
      sectorCode: 'sales',
      sectorTitle: 'Sales & Management',
      applicantsCount: 3,
    ),
    ProfessionSearchItem(
      id: 'prof_construction_worker',
      nameEn: 'Construction Worker',
      nameAr: 'عامل بناء وإنشاءات',
      sectorCode: 'construction',
      sectorTitle: 'Engineering & Construction',
      applicantsCount: 18,
    ),
    ProfessionSearchItem(
      id: 'prof_general_nurse',
      nameEn: 'General Nurse',
      nameAr: 'ممرض عام',
      sectorCode: 'medical',
      sectorTitle: 'Medical and Healthcare Sector',
      applicantsCount: 12,
    ),
    ProfessionSearchItem(
      id: 'prof_electrician',
      nameEn: 'Building Electrician',
      nameAr: 'كهربائي مباني وتمديدات',
      sectorCode: 'technical',
      sectorTitle: 'Technicians & Maintenance',
      applicantsCount: 15,
    ),
    ProfessionSearchItem(
      id: 'prof_ac_tech',
      nameEn: 'Central AC Technician',
      nameAr: 'فني تكييف مركزي',
      sectorCode: 'technical',
      sectorTitle: 'Technicians & Maintenance',
      applicantsCount: 14,
    ),
    ProfessionSearchItem(
      id: 'prof_driver',
      nameEn: 'Courier Car Delivery Driver',
      nameAr: 'سائق توصيل طلبات',
      sectorCode: 'drivers',
      sectorTitle: 'Drivers & Logistics',
      applicantsCount: 20,
    ),
    ProfessionSearchItem(
      id: 'prof_barista',
      nameEn: 'Professional Barista',
      nameAr: 'باريستا محترف',
      sectorCode: 'restaurants',
      sectorTitle: 'Restaurants & Hospitality',
      applicantsCount: 8,
    ),
    ProfessionSearchItem(
      id: 'prof_civil_eng',
      nameEn: 'Civil Site Engineer',
      nameAr: 'مهندس مدني موقع',
      sectorCode: 'construction',
      sectorTitle: 'Engineering & Construction',
      applicantsCount: 7,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _sectors = _defaultSectors;
    _professions = _defaultProfessions;
    _fetchSearchResults('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchSearchResults(String query) async {
    try {
      final response = await _apiClient.dio.get(
        '/company/search',
        queryParameters: {'query': query.trim()},
      );
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map) {
          final sList = (data['sectors'] as List? ?? [])
              .map((e) => SectorSearchItem.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          final pList = (data['professions'] as List? ?? [])
              .map((e) => ProfessionSearchItem.fromJson(Map<String, dynamic>.from(e)))
              .toList();

          if (mounted) {
            setState(() {
              _sectors = sList;
              _professions = pList;
            });
            return;
          }
        }
      }
    } catch (_) {
      // Fallback to local filter if backend offline
    }

    _filterLocally(query);
  }

  void _filterLocally(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      if (mounted) {
        setState(() {
          _sectors = _defaultSectors;
          _professions = _defaultProfessions;
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _sectors = _defaultSectors.where((s) {
          return s.nameEn.toLowerCase().contains(q) ||
              s.nameAr.toLowerCase().contains(q) ||
              s.code.toLowerCase().contains(q);
        }).toList();

        _professions = _defaultProfessions.where((p) {
          return p.nameEn.toLowerCase().contains(q) ||
              p.nameAr.toLowerCase().contains(q) ||
              p.sectorTitle.toLowerCase().contains(q);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isArabic = loc.isArabic;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                    child: InkWell(
                      onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Icon(
                          isRtl ? Icons.arrow_forward : Icons.arrow_back,
                          color: const Color(0xFF1E293B),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    loc['search'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ),

            // "Employers" Pill (Screenshot visual indicator)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEA580C), Color(0xFFF59E0B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEA580C).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  loc['employers'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Search Bar Input Field matching Screenshot
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {});
                    _fetchSearchResults(val);
                  },
                  decoration: InputDecoration(
                    hintText: loc.isArabic ? 'ابحث عن قطاع أو مهنة...' : 'Search sectors or professions...',
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF1E293B), size: 22),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: Color(0xFF475569)),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                              _fetchSearchResults('');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Grouped Results List: Sectors & Professions
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                children: [
                  // 1. Sectors Section (Green Theme)
                  if (_sectors.isNotEmpty) ...[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            size: 16,
                            color: Color(0xFF16A34A),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          loc['sectors'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_sectors.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF16A34A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Sectors Cards
                    ..._sectors.map((sector) {
                      final sectorName = sector.localizedName(isArabic);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            context.push(
                              '/sector-applicants?sector=${sector.code}&sectorTitle=${Uri.encodeComponent(sectorName)}',
                            );
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  // Left Green Accent Bar
                                  Container(
                                    width: 4,
                                    color: const Color(0xFF10B981),
                                  ),
                                  const SizedBox(width: 12),

                                  // Green Grid Icon Container
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.grid_view_rounded,
                                      color: Color(0xFF10B981),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Sector Text Column
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loc['sector_label'],
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF94A3B8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            sectorName,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F172A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Chevron
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14, left: 14),
                                    child: Icon(
                                      isRtl ? Icons.chevron_left : Icons.chevron_right,
                                      color: const Color(0xFF94A3B8),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 14),
                  ],

                  // 2. Professions Section (Amber Theme)
                  if (_professions.isNotEmpty) ...[
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.groups_outlined,
                            size: 16,
                            color: Color(0xFFD97706),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          loc['professions'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_professions.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Professions Cards
                    ..._professions.map((prof) {
                      final profTitle = prof.localizedName(isArabic);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            context.push(
                              '/sector-applicants?sector=${prof.sectorCode}&sectorTitle=${Uri.encodeComponent(prof.sectorTitle)}&profession=${Uri.encodeComponent(profTitle)}',
                            );
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  // Left Amber Accent Bar
                                  Container(
                                    width: 4,
                                    color: const Color(0xFFF59E0B),
                                  ),
                                  const SizedBox(width: 12),

                                  // Amber People Icon Container
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.person_search_outlined,
                                      color: Color(0xFFD97706),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Profession Text Column
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            loc['profession_label'],
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF94A3B8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            profTitle,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF0F172A),
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          // "👥 View applicants" Link Row
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.people_alt_rounded,
                                                size: 14,
                                                color: Color(0xFF2563EB),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                loc['view_applicants'],
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD97706),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Chevron
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14, left: 14),
                                    child: Icon(
                                      isRtl ? Icons.chevron_left : Icons.chevron_right,
                                      color: const Color(0xFF94A3B8),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 14),
                  ],

                  if (_sectors.isEmpty && _professions.isEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.search_off, size: 48, color: Color(0xFF94A3B8)),
                            const SizedBox(height: 12),
                            Text(
                              loc['no_results_found'],
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';

class SectorProfessionsScreen extends ConsumerStatefulWidget {
  final String sectorCode;
  final String sectorTitle;
  final String locationType; // 'inside' or 'outside'

  const SectorProfessionsScreen({
    super.key,
    required this.sectorCode,
    required this.sectorTitle,
    this.locationType = 'inside',
  });

  @override
  ConsumerState<SectorProfessionsScreen> createState() => _SectorProfessionsScreenState();
}

class _SectorProfessionsScreenState extends ConsumerState<SectorProfessionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSubSector = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final sector = KuwaitData.jobSeekerSectors.firstWhere(
      (s) => s['code'] == widget.sectorCode,
      orElse: () => KuwaitData.jobSeekerSectors.first,
    );
    final rawSubSectors = (sector['subSectors'] as List<dynamic>?) ?? [];
    final validSubSectors = rawSubSectors.where((s) => s.toString() != 'All').toList();
    if (validSubSectors.isNotEmpty) {
      _selectedSubSector = validSubSectors.first.toString();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _localizedSubSector(String sub, bool isArabic) {
    if (!isArabic) return sub;
    switch (sub) {
      // Construction
      case 'Concrete & Structure':
        return 'الخرسانة والهيكل';
      case 'Rebar & Steel':
        return 'الحدادة والتسليح';
      case 'Interior Finishing':
      case 'Interior & Exterior Finishing':
        return 'التشطيبات والديكور';
      case 'Plumbing, Electrical & AC':
      case 'MEP, Electric & AC':
        return 'السباكة والكهرباء والتكييف';
      case 'Facades, Aluminum & Glass':
      case 'Facades, Aluminium & Glass':
      case 'Aluminium & Glass':
        return 'الواجهات والألمنيوم والزجاج';
      case 'Safety & Site Management':
        return 'إدارة الموقع والسلامة';
      case 'Warehouses & Site Support':
      case 'Warehouse & Site Support':
        return 'المستودعات والدعم الميداني';
      case 'Heavy Construction & Earthmoving Equipment Drivers':
      case 'Heavy Construction & Earthmoving Equipment':
        return 'سائقو المعدات الثقيلة والحفريات';
      case 'Heavy Lifting & Cranes Drivers':
      case 'Heavy Lifting & Cranes':
        return 'سائقو الرافعات والرفع الثقيل';
      // Drivers & Transport
      case 'Drivers & Delivery':
        return 'السائقين والتوصيل';
      case 'Fleet Operations':
        return 'عمليات وتشغيل الأساطيل';
      case 'Heavy & Medium Transport Trucks':
        return 'شاحنات ونقل ثقيل ومتوسط';
      case 'Light & Warehouse Equipment Drivers':
        return 'سائقو معدات خفيفة ومستودعات';
      case 'Warehouse & Sorting':
        return 'المستودعات والفرز اللوجستي';
      case 'Logistics & Fleet Support':
        return 'الدعم اللوجستي والعمليات';
      case 'Heavy Equipment & Cranes':
        return 'المعدات الثقيلة والرافعات';
      // Medical
      case 'Doctors':
      case 'Doctors & Consultants':
        return 'الأطباء والاستشاريون';
      case 'Nursing':
        return 'التمريض';
      case 'Labs & Imaging':
      case 'Laboratory & Radiology':
        return 'المختبرات والأشعة';
      case 'Pharmacy':
        return 'الصيدلة';
      case 'Rehabilitation & Physical Therapy':
      case 'Physiotherapy':
        return 'التأهيل والعلاج الطبيعي';
      case 'Medical Administration':
      case 'General Healthcare':
        return 'الإدارة الطبية والرعاية العامة';
      // Restaurants & Hospitality
      case 'Restaurants':
      case 'Kitchen & Chefs':
        return 'المطاعم والطهاة';
      case 'Hotels':
        return 'الفنادق والضيافة';
      case 'Cafes':
      case 'Barista & Drinks':
        return 'المقاهي والكافيهات';
      case 'Qahwa':
        return 'المقاهي الشعبية والقهاوي';
      // Accounting & Banking
      case 'Retail & Branch Banking Service':
        return 'الخدمات المصرفية للأفراد والفروع';
      case 'Exchange House & Remittance':
        return 'شركات الصرافة والتحويلات';
      case 'Credit, Operations & Support':
        return 'الائتمان والعمليات والدعم';
      case 'General Accounting & Auditing':
        return 'المحاسبة والتدقيق العام';
      // Digital Marketing
      case 'Social Media & Content':
        return 'التواصل الاجتماعي والمحتوى';
      case 'Paid Ads & Analytics':
        return 'الإعلانات الممولة والتحليلات';
      case 'Photo & Video Production':
        return 'الإنتاج المرئي والتصوير';
      case 'Design & 3D':
        return 'التصميم والـ 3D';
      // Insurance
      case 'Health Insurance':
        return 'التأمين الصحي';
      case 'Vehicle Insurance':
        return 'تأمين المركبات';
      case 'Life Insurance':
        return 'التأمين على الحياة';
      case 'Property Insurance':
        return 'تأمين الممتلكات والمنشآت';
      case 'Claims Management':
        return 'إدارة التعويضات والمطالبات';
      case 'Insurance Sales':
        return 'مبيعات وتسويق التأمين';
      // Aviation
      case 'Flight Crew':
        return 'طاقم قيادة الطائرات';
      case 'Cabin Crew':
        return 'طاقم الضيافة الجوية';
      case 'Aviation Engineering':
        return 'هندسة وصيانة الطيران';
      case 'Ground Operations':
        return 'العمليات الأرضية';
      case 'Airport Services':
        return 'خدمات المطار والمسافرين';
      // Tailoring
      case 'Men Tailoring':
        return 'الخياطة والتفصيل الرجالي';
      case 'Women Tailoring':
        return 'الخياطة والتفصيل النسائي';
      case 'Embroidery & Decoration':
        return 'التطريز والزخرفة والشك';
      case 'Workshop Management':
        return 'إدارة وتشغيل المشاغل';
      // Car Rental & Showrooms
      case 'Showroom Management':
        return 'إدارة معارض السيارات';
      case 'Sales Team':
        return 'فريق مبيعات السيارات';
      case 'Rental Operations':
        return 'عمليات وتشغيل التأجير';
      case 'Customer Service':
        return 'خدمة العملاء والاستقبال';
      case 'Administrative Support':
        return 'الدعم الإداري والخدمات';
      // Security
      case 'Static Site Security (Facilities)':
        return 'أمن وحراسة المنشآت الثابتة';
      case 'Cash in Transit & Valuable Custody':
        return 'نقل الأموال وحراسة العهد الثمينة';
      case 'Electronic Security & Control Room':
        return 'الأمن الإلكتروني وغرف المراقبة';
      case 'Supervision & Training':
        return 'الإشراف والتدريب الأمني';
      // Medical Engineering
      case 'Clinical Engineering & Hospital Equipment':
        return 'الهندسة الإكلينيكية وتجهيزات المستشفيات';
      case 'Medical Device Manufacturing':
        return 'تصنيع وتطوير الأجهزة الطبية';
      case 'Field Services & Technical Support':
        return 'الخدمات الميدانية والدعم الفني الطبي';
      case 'Medical Imaging & Diagnostics':
        return 'التصوير الطبي والأشعة التشخيصية';
      case 'Rehabilitation & Assistive Technology':
        return 'التأهيل والتقنيات والأطراف المساعدة';
      case 'Research & Development (R&D)':
        return 'البحث والتطوير الطبي الحيوي';
      case 'Healthcare Systems & Informatics':
        return 'أنظمة المعلوماتية الصحية والبرمجيات';
      // Sports & Health
      case 'Fitness & Professional Training':
        return 'اللياقة والتدريب الرياضي الاحترافي';
      case 'Spa, Recovery & Wellness':
        return 'السبا والاستشفاء والمساج والعافية';
      case 'Gym Management & Operations':
        return 'إدارة وتشغيل النوادي والمعاهد الصحية';
      // Agriculture & Livestock
      case 'Agriculture & Crops Farming':
        return 'الزراعة وإنتاج المحاصيل';
      case 'Animal Husbandry & Livestock':
        return 'تربية الماشية والإنتاج الحيواني';
      // Factories
      case 'Factory Management & QA':
        return 'إدارة المصانع وضمان الجودة';
      case 'Factory Production & Lines':
        return 'خطوط الإنتاج والتصنيع';
      case 'Industrial Maintenance & Engineering':
        return 'الصيانة والهندسة الصناعية';
      case 'Warehouse, Logistics & Inventory':
        return 'المستودعات والخدمات اللوجستية';
      case 'Industrial Support & Facilities':
        return 'الدعم الصناعي والمرافق';
      // Sales & Retail
      case 'Neighborhood & Specialized Shops':
        return 'محلات البقالة والأنشطة المتخصصة';
      case 'Malls, Essentials & Apparel':
        return 'المجمعات والأزياء والتجزئة';
      case 'Cooperative Societies':
        return 'الجمعيات التعاونية';
      case 'Mobiles, Tech & Electronics':
        return 'الهواتف والتكنولوجيا والإلكترونيات';
      case 'Digital, E-Commerce & Tele-Sales':
        return 'المبيعات الرقمية والتيلي سيلز';
      case 'Fragrances, Oud & Tobacco':
        return 'العطور والعود والتبغ';
      case 'Roasteries, Spices & Dates':
        return 'المطاحن والبهارات والتمور';
      case 'Fabrics, Tailoring & Traditional Wear':
        return 'الأقمشة والخياطة والملبوسات';
      case 'Fish, Meat & Poultry Markets':
        return 'أسواق اللحوم والأسماك والدواجن';
      case 'Gifts, Flowers & Events':
        return 'الهدايا والزهور والمناسبات';
      case 'Hardware, Plumbing & Auto Parts':
        return 'المواد الصحية والعدد والسيارات';
      case 'Stationery, Printing & Services':
        return 'القرطاسية والطباعة والخدمات';
      case 'Corporate & B2B Sales':
        return 'مبيعات الشركات والـ B2B';
      case 'Outdoor & Field Distribution':
        return 'المبيعات والتوزيع الخارجي';
      // Oil, Gas & Petrochemicals
      case 'Upstream, Exploration & Drilling':
        return 'الاستكشاف والحفر (Upstream)';
      case 'Downstream, Refining & Petrochemicals':
        return 'التكرير والبتروكيماويات (Downstream)';
      case 'Engineering & EPC Projects':
        return 'المشاريع الهندسية وEPC';
      case 'Plant Maintenance & Turnaround':
        return 'صيانة المصافي والعمرات (Turnaround)';
      case 'Quality Assurance & HSE':
        return 'توكيد الجودة والسلامة والبيئة HSE';
      default:
        return sub;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;

    // Find the sector in KuwaitData
    final sector = KuwaitData.jobSeekerSectors.firstWhere(
      (s) => s['code'] == widget.sectorCode,
      orElse: () => KuwaitData.jobSeekerSectors.first,
    );

    final sectorImage = sector['image'] as String? ?? 'assets/images/sector_construction.jpg';
    final rawSubSectors = (sector['subSectors'] as List<dynamic>?) ?? [];
    final subSectors = rawSubSectors.where((s) => s.toString() != 'All').toList();
    if ((_selectedSubSector.isEmpty || _selectedSubSector == 'All' || !subSectors.contains(_selectedSubSector)) && subSectors.isNotEmpty) {
      _selectedSubSector = subSectors.first.toString();
    }
    final allProfessions = (sector['professions'] as List<dynamic>?) ?? [];

    // Filter by sub-sector and search query
    final filteredProfessions = allProfessions.where((p) {
      final nameEn = (p['name_en'] ?? '').toString().toLowerCase();
      final nameAr = (p['name_ar'] ?? '').toString().toLowerCase();
      final subSector = (p['subSector'] ?? '').toString();

      final matchesSubSector = subSector == _selectedSubSector;
      final q = _searchQuery.toLowerCase().trim();
      final matchesQuery = q.isEmpty || nameEn.contains(q) || nameAr.contains(q);

      return matchesSubSector && matchesQuery;
    }).toList();

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
              widget.sectorTitle,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              l10n.translate('choose_profession_subtitle'),
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
            // Sector Hero Banner
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppColors.softShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      sectorImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFFDE68A),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            widget.sectorTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: l10n.translate('search_profession_hint'),
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18, color: Color(0xFF94A3B8)),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Sub-sector Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: subSectors.map((sub) {
                  final subName = sub.toString();
                  final isSelected = _selectedSubSector == subName;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedSubSector = subName),
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
                          _localizedSubSector(subName, isArabic),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : const Color(0xFF334155),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),

            // Header: Available Professions + count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n.translate('available_professions'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                Text(
                  '${filteredProfessions.length} ${l10n.translate('professions_count_suffix')}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Professions list cards
            ...filteredProfessions.map((prof) {
              final profName = isArabic ? prof['name_ar'] : prof['name_en'];
              return _buildProfessionCard(
                title: profName,
                isArabic: isArabic,
                onTap: () {
                  context.push(
                    Uri(
                      path: '/job-application-form',
                      queryParameters: {
                        'sectorCode': widget.sectorCode,
                        'sectorTitle': widget.sectorTitle,
                        'profession': profName,
                        'locationType': widget.locationType,
                      },
                    ).toString(),
                  );
                },
              );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionCard({
    required String title,
    required bool isArabic,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: AppColors.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: Row(
              children: [
                // Accent left stripe
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 14),

                // Profession Name
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),

                // Chevron icon
                Icon(
                  isArabic ? Icons.chevron_left : Icons.chevron_right,
                  color: const Color(0xFF94A3B8),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

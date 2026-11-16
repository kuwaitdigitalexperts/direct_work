import 'dart:async';
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/app_preferences.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../shared/widgets/app_dialogs.dart';
import '../../shared/widgets/language_selector_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Function(int) onNavigateTab;

  const HomeScreen({
    super.key,
    required this.onNavigateTab,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final PageController _bannerPageController;
  int _currentBannerIndex = 0;
  Timer? _carouselTimer;

  final List<String> _companyBanners = [
    'assets/images/company_banner_kde_prayer.jpg',
    'assets/images/company_banner_kde_services.jpg',
    'assets/images/company_banner_kde_brand.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController();
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerPageController.hasClients) {
        final nextPage = (_currentBannerIndex + 1) % _companyBanners.length;
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _bannerPageController.dispose();
    super.dispose();
  }

  Future<void> _openSupportWhatsApp() async {
    final url = Uri.parse('https://wa.me/96599112233');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _showCvUploadSheet(BuildContext context, String candidateType, AppLocalizations l10n) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final professionController = TextEditingController();
    String? pickedCvName;
    String? pickedCvPath;
    int? pickedCvSizeBytes;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            String formatSize(int? bytes) {
              if (bytes == null || bytes <= 0) return '';
              if (bytes < 1024) return '$bytes B';
              if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
              return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            candidateType == 'gcc'
                                ? l10n.translate('upload_cv_gcc_title')
                                : l10n.translate('upload_cv_kuwait_title'),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => Navigator.pop(sheetContext),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.isArabic
                            ? 'انضم إلى قاعدة بيانات الكفاءات المعتمدة ليصل ملفك مباشرة إلى مئات الشركات في دولة الكويت.'
                            : 'Join the verified talent pool to connect directly with hundreds of companies in Kuwait.',
                        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: l10n.translate('full_name'),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: l10n.translate('phone'),
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('🇰🇼', style: TextStyle(fontSize: 18)),
                                SizedBox(width: 6),
                                Text(
                                  '+965',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(width: 6),
                                SizedBox(height: 18, child: VerticalDivider(width: 1, color: AppColors.border)),
                                SizedBox(width: 4),
                              ],
                            ),
                          ),
                          hintText: '9XXXXXXX',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: professionController,
                        decoration: InputDecoration(
                          labelText: l10n.translate('profession'),
                          prefixIcon: const Icon(Icons.work_outline),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Real File Picker Box
                      GestureDetector(
                        onTap: () async {
                          try {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc', 'docx'],
                            );
                            if (result != null && result.files.isNotEmpty) {
                              setSheetState(() {
                                pickedCvName = result.files.first.name;
                                pickedCvPath = result.files.first.path;
                                pickedCvSizeBytes = result.files.first.size;
                              });
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('File picker error: $e')),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: pickedCvName != null ? const Color(0xFFEFF6FF) : AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: pickedCvName != null ? AppColors.primary : AppColors.border,
                              width: pickedCvName != null ? 1.5 : 1.0,
                            ),
                          ),
                          child: pickedCvName != null
                              ? Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEF4444).withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.picture_as_pdf, color: Color(0xFFEF4444), size: 26),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pickedCvName!,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${formatSize(pickedCvSizeBytes)} • ${l10n.isArabic ? 'جاهز للإرفاق' : 'Ready to attach'}',
                                            style: const TextStyle(fontSize: 11, color: Color(0xFF10B981), fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        try {
                                          final result = await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['pdf', 'doc', 'docx'],
                                          );
                                          if (result != null && result.files.isNotEmpty) {
                                            setSheetState(() {
                                              pickedCvName = result.files.first.name;
                                              pickedCvPath = result.files.first.path;
                                              pickedCvSizeBytes = result.files.first.size;
                                            });
                                          }
                                        } catch (_) {}
                                      },
                                      child: Text(
                                        l10n.isArabic ? 'تغيير' : 'Change',
                                        style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Icon(Icons.cloud_upload_outlined, size: 36, color: AppColors.primary),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.translate('upload_cv'),
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.isArabic ? 'انقر لاختيار السيرة الذاتية (PDF أو Word بحد أقصى 10MB)' : 'Tap to select CV (PDF or Word, max 10MB)',
                                      style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (pickedCvName != null) {
                              await AppPreferences.setString('user_saved_cv_name', pickedCvName!);
                              if (pickedCvPath != null) {
                                await AppPreferences.setString('user_saved_cv_path', pickedCvPath!);
                              }
                              await AppPreferences.setString('user_saved_cv_size', formatSize(pickedCvSizeBytes));
                            }
                            if (context.mounted) {
                              Navigator.pop(sheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    pickedCvName != null
                                        ? (l10n.isArabic
                                            ? 'تم حفظ سيرتك الذاتية بنجاح! سيتم ربطها تلقائياً مع طلباتك القادمة.'
                                            : 'CV saved successfully! It will be pre-loaded in your job applications.')
                                        : (l10n.isArabic
                                            ? 'تم استلام بياناتك بنجاح!'
                                            : 'Your profile has been saved successfully!'),
                                  ),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            l10n.translate('continue_btn'),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authProvider).user;

    // Company view is strictly tied to the account role created by the user
    final isCompany = user?.role == UserRole.company;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: CustomScrollView(
        slivers: [
          // Top Royal Blue Gradient Header
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1D4ED8), // Royal Blue
                    Color(0xFF3B82F6), // Vibrant Sky Blue
                    Color(0xFFEFF6FF), // Soft Ice Blue
                    Color(0xFFFBFBFB), // Body Background
                  ],
                  stops: [0.0, 0.45, 0.8, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                  child: Column(
                    children: [
                      // Top Row: Circular Actions & Language Switcher
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left Circular Buttons Group
                          Row(
                            children: [
                              // Country Flag Circle / Back Arrow (Hidden - App is currently exclusively for Kuwait)
                              /*
                              InkWell(
                                onTap: () => context.push('/market-selection'),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 22,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF006C35), // Flag green
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '🇰🇼',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              */

                              // Profile Avatar Circle
                              InkWell(
                                onTap: () => context.push('/profile'),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    color: Color(0xFF57534E),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),

                              // Notification Bell Circle
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.translate('no_notifications')),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: Color(0xFF57534E),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Right Side: Multi-Language Selector Pill (9 Languages)
                          InkWell(
                            onTap: () => LanguageSelectorSheet.show(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.06),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        l10n.currentLanguage.flag,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        l10n.currentLanguage.code.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF292524),
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        size: 16,
                                        color: Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      const SizedBox(height: 18),

                      // Platform Main Brand Title & Subtitle
                      Text(
                        l10n.translate('direct_jobs_app_title'),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.translate('hiring_platform_subtitle'),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Banners Carousel (Exact Screenshots 1, 2, 4)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 190,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Carousel View
                              PageView.builder(
                                controller: _bannerPageController,
                                itemCount: _companyBanners.length,
                                onPageChanged: (idx) {
                                  setState(() => _currentBannerIndex = idx);
                                },
                                itemBuilder: (context, idx) {
                                  return GestureDetector(
                                    onTap: () => AppDialogs.showAvailableSoonTopNotice(context),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        // Ambient backdrop blurred to matching image palette
                                        Image.asset(
                                          _companyBanners[idx],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                        BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                          child: Container(
                                            color: Colors.black.withOpacity(0.12),
                                          ),
                                        ),
                                        // Crisp, centered, uncropped banner
                                        Center(
                                          child: Image.asset(
                                            _companyBanners[idx],
                                            fit: BoxFit.contain,
                                            height: 190,
                                            errorBuilder: (_, __, ___) => _buildFallbackHeroBanner(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              // Royal Blue DW Badge on upper corner
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Direct Work',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Carousel Indicator Dots (Screenshot 1 & 2)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_companyBanners.length, (dotIndex) {
                          final isSelected = _currentBannerIndex == dotIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: isSelected ? 22 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : const Color(0xFFCBD5E1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 10),

                      // Upload Banner Contact Strip (All Screenshots)
                      InkWell(
                        onTap: () => AppDialogs.showAvailableSoonTopNotice(context),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFBFDBFE), width: 1.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone_in_talk_outlined,
                                color: Color(0xFF1D4ED8),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  l10n.translate('banner_contact_text'),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E3A8A),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 11,
                                color: Color(0xFF1D4ED8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content Body: Company Mode vs Job Seeker Mode
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
              child: isCompany ? _buildCompanyBody(context, l10n) : _buildSeekerBody(context, l10n),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // COMPANY / EMPLOYER VIEW (Screenshots 1, 2, 4)
  // -------------------------------------------------------------
  Widget _buildCompanyBody(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        // Card 0: "Companies & Business Owners" (Screenshot 1)
        _buildActionCard(
          context: context,
          icon: Icons.apartment_rounded,
          iconBgColor: const Color(0xFFFFF7ED),
          iconColor: const Color(0xFFD97706),
          chevronColor: const Color(0xFFFED7AA),
          title: l10n.translate('company_business_owners_title'),
          subtitle: l10n.translate('company_business_owners_desc'),
          buttonLabel: l10n.translate('view_companies_btn'),
          isOutlinedButton: true,
          buttonColor: AppColors.primary,
          onTap: () => context.push('/company-sectors?locationType=inside'),
        ),
        const SizedBox(height: 14),

        // Card 1: "View job seeker ads within Kuwait" (Screenshot 2)
        _buildActionCard(
          context: context,
          icon: Icons.people_alt_outlined,
          iconBgColor: const Color(0xFFEFF6FF),
          iconColor: AppColors.primary,
          chevronColor: const Color(0xFFBFDBFE),
          title: l10n.translate('view_seeker_ads_kw_title'),
          subtitle: l10n.translate('view_seeker_ads_kw_desc'),
          buttonLabel: l10n.translate('view_ads_btn'),
          buttonColor: AppColors.primary,
          onTap: () => context.push('/company-sectors?locationType=inside'),
        ),
        const SizedBox(height: 14),

        // Card 2: "View job seeker ads from abroad" (Screenshot 2)
        _buildActionCard(
          context: context,
          icon: Icons.public,
          iconBgColor: const Color(0xFFFDF2F8),
          iconColor: const Color(0xFFDB2777),
          chevronColor: const Color(0xFFF472B6),
          title: l10n.translate('view_seeker_ads_abroad_title'),
          subtitle: l10n.translate('view_seeker_ads_abroad_desc'),
          buttonLabel: l10n.translate('view_overseas_btn'),
          isGradientButton: true,
          buttonColor: const Color(0xFFBE185D),
          onTap: () => context.push('/company-sectors?locationType=outside'),
        ),
        const SizedBox(height: 14),

        // Card 3: "View part-time job ads within Kuwait" (Screenshot 2 & 4)
        _buildActionCard(
          context: context,
          icon: Icons.access_time_rounded,
          iconBgColor: const Color(0xFFFFFBEB),
          iconColor: const Color(0xFFD97706),
          chevronColor: const Color(0xFFFDE68A),
          title: l10n.translate('view_part_time_ads_title'),
          subtitle: l10n.translate('view_part_time_ads_desc'),
          badgeText: l10n.translate('temp_work_permit_badge'),
          buttonLabel: l10n.translate('part_time_btn'),
          buttonColor: const Color(0xFFD97706),
          isGradientButton: true,
          gradientColors: const [Color(0xFFF59E0B), Color(0xFFD97706)],
          onTap: () {
            ref.read(jobsProvider.notifier).setWorkType('part_time');
            context.push('/company-sectors?locationType=part_time');
          },
        ),
        const SizedBox(height: 18),

        // Bottom Side-by-Side Cards (Screenshot 4)
        Row(
          children: [
            // Left Card: "Browse GCC citizens applications"
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6), // Soft warm cream
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Circular Avatar + Employment Tag
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            'assets/images/arabman.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person,
                              color: Color(0xFFD97706),
                              size: 24,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Text(
                            l10n.translate('employment_tag'),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB45309),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.translate('browse_gcc_apps_title'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78350F),
                        height: 1.3,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(jobsProvider.notifier).setCandidateCategory('gcc_citizen');
                        widget.onNavigateTab(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD97706),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        l10n.translate('browse_apps_btn'),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Right Card: "Browse No-Nationality applications"
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF831843), // Rich Plum / Deep Berry
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Circular Document Avatar + Employment Tag
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            l10n.translate('employment_tag'),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.translate('browse_no_nationality_title'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(jobsProvider.notifier).setCandidateCategory('resident');
                        widget.onNavigateTab(1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9D174D),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(color: Color(0xFFF472B6), width: 1),
                        minimumSize: const Size(0, 36),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        l10n.translate('browse_apps_btn'),
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // -------------------------------------------------------------
  // JOB SEEKER VIEW
  // -------------------------------------------------------------
  Widget _buildSeekerBody(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        // Section Divider "──────  Job Seekers  ──────"
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                l10n.translate('job_seekers_heading'),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
          ],
        ),
        const SizedBox(height: 16),

        // Card 1: Apply inside Kuwait
        _buildActionCard(
          context: context,
          icon: Icons.people_alt_outlined,
          iconBgColor: const Color(0xFFFFF7ED),
          iconColor: const Color(0xFFEA580C),
          chevronColor: const Color(0xFFFB923C),
          title: l10n.translate('apply_inside_kuwait_title'),
          subtitle: l10n.translate('apply_inside_kuwait_desc'),
          buttonLabel: l10n.translate('apply_now'),
          buttonColor: const Color(0xFFEA580C),
          onTap: () {
            final user = ref.read(authProvider).user;
            final isInsideKuwait = user != null && user.isInsideKuwait;
            if (!isInsideKuwait) {
              AppDialogs.showInsideApplicationNotice(context);
            } else {
              context.push('/select-sector?locationType=inside');
            }
          },
        ),
        const SizedBox(height: 14),

        // Card 2: Overseas applicants
        _buildActionCard(
          context: context,
          icon: Icons.public,
          iconBgColor: const Color(0xFFFDF2F8),
          iconColor: const Color(0xFFDB2777),
          chevronColor: const Color(0xFFF472B6),
          title: l10n.translate('jobs_outside_title'),
          subtitle: l10n.translate('jobs_outside_desc'),
          buttonLabel: l10n.translate('apply_overseas_btn'),
          buttonColor: const Color(0xFFBE185D),
          isGradientButton: true,
          onTap: () => context.push('/select-sector?locationType=outside'),
        ),
        const SizedBox(height: 14),

        // Card 3: Part-Time Job in Kuwait (دوام جزئي داخل الكويت)
        _buildActionCard(
          context: context,
          icon: Icons.access_time_rounded,
          iconBgColor: const Color(0xFFFFFBEB),
          iconColor: const Color(0xFFD97706),
          chevronColor: const Color(0xFFFDE68A),
          title: l10n.translate('view_part_time_ads_title'),
          subtitle: l10n.translate('view_part_time_ads_desc'),
          badgeText: l10n.translate('temp_work_permit_badge'),
          buttonLabel: l10n.translate('part_time_btn'),
          buttonColor: const Color(0xFFD97706),
          isGradientButton: true,
          gradientColors: const [Color(0xFFF59E0B), Color(0xFFD97706)],
          onTap: () {
            ref.read(jobsProvider.notifier).setWorkType('part_time');
            final user = ref.read(authProvider).user;
            final isInsideKuwait = user != null && user.isInsideKuwait;
            if (!isInsideKuwait) {
              AppDialogs.showInsideApplicationNotice(context);
            } else {
              context.push('/select-sector?locationType=part_time');
            }
          },
        ),
        const SizedBox(height: 18),

        // Bottom CV Upload Cards
        Row(
          children: [
            // GCC Citizens CV
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3D6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/arabman.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.translate('upload_cv_gcc_title'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF78350F),
                        height: 1.3,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => _showCvUploadSheet(context, 'gcc', l10n),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD97706),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        l10n.translate('upload_cv_btn'),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Kuwait Citizens CV
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF006C35),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/arabman.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.translate('upload_cv_kuwait_title'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => _showCvUploadSheet(context, 'kuwait', l10n),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004D25),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        l10n.translate('upload_cv_btn'),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // -------------------------------------------------------------
  // REUSABLE ACTION CARD (Matches Screenshot 1, 2, 4)
  // -------------------------------------------------------------
  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color chevronColor,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required Color buttonColor,
    String? badgeText,
    bool isOutlinedButton = false,
    bool isGradientButton = false,
    List<Color>? gradientColors,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon + Title & Subtitle + Chevron
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(icon, color: iconColor, size: 24),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 11,
                        color: chevronColor,
                      ),
                    ),
                  ],
                ),

                // Optional Middle Pill Badge (e.g. "With a temporary work permit")
                if (badgeText != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBEB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 14),

                // Bottom Align Button
                Align(
                  alignment: Alignment.centerRight,
                  child: isOutlinedButton
                      ? OutlinedButton(
                          onPressed: onTap,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: buttonColor,
                            side: BorderSide(color: buttonColor, width: 1.5),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            minimumSize: const Size(0, 36),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text(
                            buttonLabel,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        )
                      : (isGradientButton || gradientColors != null)
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColors ?? const [Color(0xFFBE185D), Color(0xFF9D174D)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: onTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  minimumSize: const Size(0, 36),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Text(
                                  buttonLabel,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                minimumSize: const Size(0, 36),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text(
                                buttonLabel,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackHeroBanner() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(Icons.business_center, size: 48, color: Colors.white),
      ),
    );
  }
}

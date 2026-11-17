import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/countries_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/country_config.dart';
import '../../providers/country_provider.dart';
import '../../providers/locale_provider.dart';

class CountrySelectionScreen extends ConsumerStatefulWidget {
  final String role; // 'company' or 'applicant'

  const CountrySelectionScreen({
    super.key,
    this.role = 'company',
  });

  @override
  ConsumerState<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends ConsumerState<CountrySelectionScreen> {
  late CountryConfig _selectedCountry;

  final List<CountryConfig> _availableCountries = [
    CountriesData.kuwait,
    CountriesData.saudi,
    CountriesData.uae,
  ];

  @override
  void initState() {
    super.initState();
    final active = ref.read(countryProvider);
    _selectedCountry = _availableCountries.firstWhere(
      (c) => c.id == active.id,
      orElse: () => CountriesData.kuwait,
    );
  }

  Future<void> _handleNext() async {
    await ref.read(countryProvider.notifier).setCountry(_selectedCountry);

    if (!mounted) return;

    if (widget.role == 'company') {
      context.push('/company-register');
    } else {
      context.push('/register?role=${widget.role}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;
    final isCompany = widget.role == 'company';
    final canPop = context.canPop();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFF6FF), // Direct Work soft blue wash
              Color(0xFFF8FAFC), // Slate clean background
              Colors.white,
            ],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Header: Language Switcher & Back Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Language switcher pill button
                    InkWell(
                      onTap: () {
                        final nextLang = isArabic ? 'en' : 'ar';
                        ref.read(localeProvider.notifier).setLocale(Locale(nextLang));
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.language_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isArabic ? 'English' : 'العربية',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (canPop)
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          isArabic ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),

                const SizedBox(height: 20),

                // Center App Logo & Brand Name
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.18),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.10),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isArabic ? 'دايركت وورك' : 'Direct Work',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Question Title
                Text(
                  isCompany
                      ? (isArabic ? 'في أي دولة تقع شركتك؟' : 'Which country is your company in?')
                      : (isArabic ? 'في أي دولة تتواجد حالياً؟' : 'Which country are you located in?'),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.25,
                  ),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),

                const SizedBox(height: 20),

                // Country Cards
                Expanded(
                  child: ListView.builder(
                    itemCount: _availableCountries.length,
                    itemBuilder: (context, index) {
                      final country = _availableCountries[index];
                      final isSelected = _selectedCountry.id == country.id;
                      return _buildCountryCard(
                        country: country,
                        isSelected: isSelected,
                        isArabic: isArabic,
                        onTap: () {
                          setState(() {
                            _selectedCountry = country;
                          });
                        },
                      );
                    },
                  ),
                ),

                // Bottom Action Button: Next
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _handleNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        isArabic ? 'التالي' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
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

  Widget _buildCountryCard({
    required CountryConfig country,
    required bool isSelected,
    required bool isArabic,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF0F7FF) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
          width: isSelected ? 2.0 : 1.2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                // Flag emoji
                Text(
                  country.flagEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 16),

                // Country name
                Expanded(
                  child: Text(
                    isArabic ? country.nameAr : country.nameEn,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                    ),
                  ),
                ),

                if (isSelected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

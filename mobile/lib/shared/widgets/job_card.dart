import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/countries_data.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_model.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;
  final VoidCallback onApply;

  const JobCard({
    super.key,
    required this.job,
    required this.onTap,
    required this.onApply,
  });

  Future<void> _launchWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = Uri.parse('https://wa.me/$cleanPhone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchCall(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: job.isPinned ? AppColors.primary.withOpacity(0.5) : const Color(0xFFE2E8F0),
          width: job.isPinned ? 1.5 : 1.0,
        ),
        boxShadow: job.isPinned
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : AppColors.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row: Pinned badge + Company Name + Time ago
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Logo Avatar with soft shadow & border
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDBEAFE), width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1D4ED8).withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: job.companyLogo != null && job.companyLogo!.isNotEmpty
                            ? Image.network(
                                job.companyLogo!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _buildCompanyInitial(),
                              )
                            : _buildCompanyInitial(),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Job Title & Company Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (job.isPinned) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFD97706), Color(0xFFB45309)],
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFD97706).withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.push_pin, size: 10, color: Colors.white),
                                      const SizedBox(width: 3),
                                      Text(
                                        l10n.translate('pinned'),
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              Expanded(
                                child: Text(
                                  job.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            job.companyName,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Time Ago / Bookmark Icon
                    Text(
                      _formatDate(job.createdAt, l10n),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  job.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Tags Row: Work Type + Governorate + Salary
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    // Work Type Tag
                    _buildTag(
                      text: _getWorkTypeLabel(job.workType, l10n),
                      icon: Icons.access_time_rounded,
                      color: job.workType == 'part_time'
                          ? AppColors.partTimePurple
                          : AppColors.primary,
                      bgColor: job.workType == 'part_time'
                          ? const Color(0xFFF5F3FF)
                          : const Color(0xFFEFF6FF),
                    ),

                    // Governorate Tag
                    _buildTag(
                      text: _getGovernorateName(job.governorateName, l10n),
                      icon: Icons.location_on_outlined,
                      color: const Color(0xFF0D9488),
                      bgColor: const Color(0xFFF0FDFA),
                    ),

                    // Salary Tag (if provided)
                    if (job.salaryKwd != null)
                      _buildTag(
                        text: '${job.salaryKwd! % 1 == 0 ? job.salaryKwd!.toInt() : job.salaryKwd} ${job.currencyLabel} / ${l10n.isArabic ? "شهرياً" : "mo"}',
                        icon: Icons.payments_outlined,
                        color: const Color(0xFF16A34A),
                        bgColor: const Color(0xFFF0FDF4),
                      ),
                  ],
                ),
                const SizedBox(height: 14),

                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),

                // Action Buttons Row: WhatsApp + Call + Direct Apply
                Row(
                  children: [
                    // WhatsApp Button
                    if (job.whatsappNumber.isNotEmpty) ...[
                      InkWell(
                        onTap: () => _launchWhatsApp(job.whatsappNumber),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25D366).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF25D366).withOpacity(0.3)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.chat_bubble_outline, size: 14, color: Color(0xFF128C7E)),
                              SizedBox(width: 4),
                              Text(
                                'واتساب',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF128C7E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],

                    // Direct Call Button
                    if (job.phoneNumber.isNotEmpty) ...[
                      InkWell(
                        onTap: () => _launchCall(job.phoneNumber),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppColors.infoLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.info.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.phone_outlined, size: 14, color: AppColors.info),
                              const SizedBox(width: 4),
                              Text(
                                l10n.translate('call'),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.info,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const Spacer(),

                    // Apply Button
                    InkWell(
                      onTap: onApply,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          gradient: job.isApplied
                              ? null
                              : const LinearGradient(
                                  colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                                ),
                          color: job.isApplied ? const Color(0xFFF1F5F9) : null,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: job.isApplied
                              ? null
                              : [
                                  BoxShadow(
                                    color: const Color(0xFF1D4ED8).withOpacity(0.25),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              job.isApplied ? Icons.check_circle : Icons.send_rounded,
                              size: 13,
                              color: job.isApplied ? AppColors.textMuted : Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              job.isApplied ? l10n.translate('applied') : l10n.translate('apply_job'),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: job.isApplied ? AppColors.textMuted : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyInitial() {
    final initial = job.companyName.isNotEmpty ? job.companyName[0] : 'C';
    return Container(
      color: const Color(0xFFEFF6FF),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildTag({
    required String text,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getWorkTypeLabel(String workType, AppLocalizations l10n) {
    switch (workType) {
      case 'part_time':
        return l10n.translate('part_time_kuwait');
      case 'freelance':
        return l10n.translate('freelance');
      case 'full_time':
      default:
        return l10n.translate('full_time');
    }
  }

  String _getGovernorateName(String code, AppLocalizations l10n) {
    for (final c in CountriesData.allCountries) {
      for (final r in c.regions) {
        if (r['id'] == code || r['code'] == code || r['name_en'] == code || r['name_ar'] == code) {
          return l10n.isArabic ? (r['name_ar'] ?? code) : (r['name_en'] ?? code);
        }
      }
    }
    return code;
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      return '${diff.inDays} ${l10n.translate('days_ago')}';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ${l10n.translate('hours_ago')}';
    } else {
      return l10n.translate('just_now');
    }
  }
}

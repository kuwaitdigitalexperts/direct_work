import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
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
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: job.isPinned ? AppColors.primary.withOpacity(0.5) : AppColors.border,
          width: job.isPinned ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Pinned badge & Posted Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (job.isPinned)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.push_pin, size: 13, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text(
                              l10n.translate('pinned_job_badge'),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    Text(
                      _formatDate(job.createdAt, l10n),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Company Header Row
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          job.companyName.isNotEmpty
                              ? job.companyName.substring(0, 1)
                              : 'K',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            job.companyName,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Badges: Location & Sector & Work Type
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildChip(
                      icon: Icons.location_on_outlined,
                      label: _getGovName(job, l10n),
                      color: AppColors.textSecondary,
                      bgColor: AppColors.surfaceVariant,
                    ),
                    _buildChip(
                      icon: Icons.work_outline,
                      label: _formatWorkType(job.workType, l10n),
                      color: job.workType == 'part_time'
                          ? AppColors.partTimePurple
                          : AppColors.textSecondary,
                      bgColor: job.workType == 'part_time'
                          ? AppColors.partTimePurple.withOpacity(0.08)
                          : AppColors.surfaceVariant,
                    ),
                    if (job.salaryKwd != null)
                      _buildChip(
                        icon: Icons.payments_outlined,
                        label: '${job.salaryKwd!.toInt()} ${l10n.translate('kwd')}',
                        color: AppColors.success,
                        bgColor: AppColors.successLight,
                      ),
                  ],
                ),
                const SizedBox(height: 14),

                // Bottom Action Row
                Row(
                  children: [
                    // WhatsApp Button
                    IconButton(
                      onPressed: () => _launchWhatsApp(job.whatsappNumber),
                      icon: const Icon(Icons.chat_bubble, color: Color(0xFF25D366), size: 22),
                      tooltip: l10n.translate('whatsapp_tooltip'),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366).withOpacity(0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Phone Call Button
                    IconButton(
                      onPressed: () => _launchCall(job.phoneNumber),
                      icon: const Icon(Icons.phone, color: AppColors.info, size: 22),
                      tooltip: l10n.translate('call_tooltip'),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.info.withOpacity(0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const Spacer(),

                    // Apply Button
                    SizedBox(
                      height: 38,
                      child: ElevatedButton(
                        onPressed: job.isApplied ? null : onApply,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: job.isApplied ? AppColors.border : AppColors.primary,
                          foregroundColor: job.isApplied ? AppColors.textMuted : Colors.white,
                          elevation: 0,
                          minimumSize: const Size(0, 38),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          job.isApplied ? l10n.translate('applied') : l10n.translate('direct_apply'),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getGovName(JobModel job, AppLocalizations l10n) {
    final gov = KuwaitData.governorates.firstWhere(
      (g) => g['id'] == job.governorateId,
      orElse: () => {'name_ar': job.governorateName, 'name_en': job.governorateName},
    );
    return l10n.isArabic ? gov['name_ar']! : gov['name_en']!;
  }

  String _formatWorkType(String type, AppLocalizations l10n) {
    switch (type) {
      case 'part_time':
        return l10n.translate('part_time_kuwait');
      case 'freelance':
        return l10n.translate('freelance_kuwait');
      case 'full_time':
      default:
        return l10n.translate('full_time');
    }
  }

  String _formatDate(DateTime dt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return l10n.translate('just_now');
    if (diff.inHours < 24) {
      return l10n.isArabic
          ? '${l10n.translate('ago')} ${diff.inHours} ${l10n.translate('hours_ago')}'
          : '${diff.inHours}${l10n.translate('hours_ago')}';
    }
    return l10n.isArabic
        ? '${l10n.translate('ago')} ${diff.inDays} ${l10n.translate('days_ago')}'
        : '${diff.inDays}${l10n.translate('days_ago')}';
  }
}

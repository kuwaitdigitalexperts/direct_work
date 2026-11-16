import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_application_model.dart';
import '../../providers/applications_provider.dart';

class MyApplicationsScreen extends ConsumerWidget {
  const MyApplicationsScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final appState = ref.watch(applicationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.translate('my_applications')),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(applicationsProvider.notifier).fetchApplications(),
          color: AppColors.primary,
          child: appState.applications.isEmpty
              ? _buildEmptyState(context, l10n)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: appState.applications.length,
                  itemBuilder: (context, index) {
                    final app = appState.applications[index];
                    return _buildApplicationCard(context, ref, app, l10n);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildApplicationCard(
    BuildContext context,
    WidgetRef ref,
    JobApplicationModel app,
    AppLocalizations l10n,
  ) {
    final statusConfig = _getStatusConfig(app.status, l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Status Chip & Applied Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusConfig.bgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusConfig.icon, size: 13, color: statusConfig.color),
                      const SizedBox(width: 5),
                      Text(
                        statusConfig.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusConfig.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatDate(app.appliedAt, l10n),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Job Title
            Text(
              app.jobTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),

            // Company & Location
            Row(
              children: [
                const Icon(Icons.business, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    app.companyName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textMuted),
                const SizedBox(width: 6),
                Text(
                  app.governorateName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                if (app.salaryKwd != null) ...[
                  const SizedBox(width: 12),
                  const Icon(Icons.payments_outlined, size: 14, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(
                    '${app.salaryKwd?.toInt() ?? 0} ${l10n.translate('kwd')}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ],
            ),
            const Divider(height: 24),

            // Bottom Actions: Direct Contact & View Details
            Row(
              children: [
                // WhatsApp
                IconButton(
                  onPressed: () => _launchWhatsApp(app.whatsappNumber),
                  icon: const Icon(Icons.chat_bubble, color: Color(0xFF25D366), size: 20),
                  tooltip: l10n.translate('whatsapp_tooltip'),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366).withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(width: 8),

                // Call
                IconButton(
                  onPressed: () => _launchCall(app.phoneNumber),
                  icon: const Icon(Icons.phone, color: AppColors.info, size: 20),
                  tooltip: l10n.translate('call_tooltip'),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.info.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const Spacer(),

                // View Details Button
                OutlinedButton.icon(
                  onPressed: () => context.push('/jobs/${app.jobId}'),
                  icon: const Icon(Icons.visibility_outlined, size: 16),
                  label: Text(l10n.isArabic ? 'تفاصيل الوظيفة' : 'Job Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryDark,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: const Size(0, 38),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 2),
              ),
              child: const Icon(Icons.assignment_outlined, size: 44, color: AppColors.primary),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.isArabic ? 'لم تتقدم لأي وظيفة حتى الآن' : 'No Applications Submitted Yet',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.isArabic
                  ? 'تصفح مئات الوظائف الشاغرة المباشرة في دولة الكويت وقدّم سيرتك الذاتية للتواصل الفوري مع أصحاب العمل.'
                  : 'Browse hundreds of direct job openings across Kuwait and apply directly to connect with employers.',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () => context.go('/home'),
                icon: const Icon(Icons.search, size: 18),
                label: Text(l10n.isArabic ? 'تصفح وظائف الكويت' : 'Explore Kuwait Jobs'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status, AppLocalizations l10n) {
    switch (status) {
      case 'shortlisted':
        return _StatusConfig(
          label: l10n.isArabic ? 'تم الترشيح للمقابلة 🎉' : 'Shortlisted for Interview 🎉',
          color: AppColors.success,
          bgColor: AppColors.successLight,
          icon: Icons.check_circle_outline,
        );
      case 'under_review':
        return _StatusConfig(
          label: l10n.isArabic ? 'قيد المراجعة والتدقيق' : 'Under Review',
          color: AppColors.warning,
          bgColor: AppColors.warning.withOpacity(0.12),
          icon: Icons.hourglass_top_rounded,
        );
      case 'rejected':
        return _StatusConfig(
          label: l10n.isArabic ? 'تم شغل الوظيفة' : 'Position Filled',
          color: AppColors.error,
          bgColor: AppColors.errorLight,
          icon: Icons.cancel_outlined,
        );
      case 'submitted':
      default:
        return _StatusConfig(
          label: l10n.isArabic ? 'تم إرسال الطلب بنجاح' : 'Application Submitted',
          color: AppColors.info,
          bgColor: AppColors.info.withOpacity(0.12),
          icon: Icons.send_rounded,
        );
    }
  }

  String _formatDate(DateTime dt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return l10n.translate('just_now');
    if (diff.inHours < 24) {
      return l10n.isArabic ? 'منذ ${diff.inHours} ساعة' : '${diff.inHours}h ago';
    }
    return l10n.isArabic ? 'منذ ${diff.inDays} يوم' : '${diff.inDays}d ago';
  }
}

class _StatusConfig {
  final String label;
  final Color color;
  final Color bgColor;
  final IconData icon;

  const _StatusConfig({
    required this.label,
    required this.color,
    required this.bgColor,
    required this.icon,
  });
}

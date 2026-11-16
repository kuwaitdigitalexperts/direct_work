import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_model.dart';
import '../../providers/chat_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../shared/widgets/app_button.dart';
import 'apply_job_sheet.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  JobModel? _job;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJob();
  }

  Future<void> _loadJob() async {
    final service = ref.read(jobsServiceProvider);
    final job = await service.getJobById(widget.jobId);
    if (mounted) {
      setState(() {
        _job = job;
        _isLoading = false;
      });
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = Uri.parse('https://wa.me/$clean');
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

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (_job == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.translate('job_not_found'))),
      );
    }

    final job = _job!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.translate('job_details')),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.translate('job_link_copied_msg'))),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        job.companyName.isNotEmpty ? job.companyName.substring(0, 1) : 'K',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.companyName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Highlights Grid (Governorate, Salary, Work Type, Sector)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildHighlightRow(
                    icon: Icons.location_on_outlined,
                    label: l10n.isArabic ? 'المحافظة والموقع' : 'Location & Governorate',
                    value: '${_getGovName(job, l10n)} - ${l10n.isArabic ? 'دولة الكويت' : 'State of Kuwait'}',
                  ),
                  const Divider(height: 20),
                  _buildHighlightRow(
                    icon: Icons.payments_outlined,
                    label: l10n.isArabic ? 'الراتب المقدر' : 'Estimated Salary',
                    value: job.salaryKwd != null
                        ? '${job.salaryKwd?.toInt() ?? 0} ${l10n.translate('salary_kwd')}'
                        : (l10n.isArabic ? 'يحدد بعد المقابلة' : 'Negotiable after interview'),
                    valueColor: AppColors.success,
                  ),
                  const Divider(height: 20),
                  _buildHighlightRow(
                    icon: Icons.badge_outlined,
                    label: l10n.isArabic ? 'القطاع والمهنة' : 'Sector & Role',
                    value: '${_getSectorName(job, l10n)} • ${job.professionName}',
                  ),
                  const Divider(height: 20),
                  _buildHighlightRow(
                    icon: Icons.access_time_rounded,
                    label: l10n.isArabic ? 'نظام الدوام' : 'Work Type',
                    value: job.workType == 'part_time'
                        ? (l10n.isArabic ? 'دوام جزئي داخل الكويت' : 'Part-time in Kuwait')
                        : (l10n.isArabic ? 'دوام كامل رسمي' : 'Official Full-time'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Description
            Text(
              l10n.isArabic ? 'الوصف الوظيفي' : 'Job Description',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                job.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Requirements
            if (job.requirements.isNotEmpty) ...[
              Text(
                l10n.translate('requirements'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: job.requirements.map((req) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.primary, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              req,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.4,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),

      // Sticky Bottom Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // In-app Direct Chat Button
            IconButton(
              onPressed: () async {
                final room = await ref.read(chatProvider.notifier).startOrGetRoom(
                  participantName: job.companyName,
                  participantRole: l10n.isArabic ? 'صاحب عمل' : 'Employer',
                  relatedJobOrService: job.title,
                );
                if (context.mounted) {
                  context.push(
                    '/chat/${room.id}?name=${Uri.encodeComponent(room.participantName)}&role=${Uri.encodeComponent(room.participantRole)}',
                  );
                }
              },
              icon: const Icon(Icons.forum_outlined, color: AppColors.primary),
              tooltip: l10n.isArabic ? 'محادثة مباشرة' : 'Direct Chat',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 8),

            // WhatsApp Button
            IconButton(
              onPressed: () => _launchWhatsApp(job.whatsappNumber),
              icon: const Icon(Icons.chat_bubble, color: Color(0xFF25D366)),
              tooltip: l10n.translate('whatsapp_tooltip'),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF25D366).withOpacity(0.12),
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 8),

            // Direct Call
            IconButton(
              onPressed: () => _launchCall(job.phoneNumber),
              icon: const Icon(Icons.phone, color: AppColors.info),
              tooltip: l10n.translate('call_tooltip'),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.info.withOpacity(0.12),
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 12),

            // Apply Button
            Expanded(
              child: AppButton(
                text: job.isApplied ? l10n.translate('already_applied') : l10n.translate('direct_apply_cv'),
                onPressed: job.isApplied
                    ? null
                    : () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          builder: (ctx) => ApplyJobSheet(
                            jobId: job.id,
                            jobTitle: job.title,
                          ),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getGovName(JobModel job, AppLocalizations l10n) {
    final gov = KuwaitData.governorates.firstWhere(
      (g) => g['id'] == job.governorateId,
      orElse: () => {'name_ar': job.governorateName, 'name_en': job.governorateName},
    );
    return (l10n.isArabic ? gov['name_ar'] : gov['name_en']) ?? job.governorateName;
  }

  String _getSectorName(JobModel job, AppLocalizations l10n) {
    final sec = KuwaitData.sectors.firstWhere(
      (s) => s['code'] == job.sectorCode,
      orElse: () => {'name_ar': job.sectorName, 'name_en': job.sectorName},
    );
    return (l10n.isArabic ? sec['name_ar'] : sec['name_en']) ?? job.sectorName;
  }

  Widget _buildHighlightRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

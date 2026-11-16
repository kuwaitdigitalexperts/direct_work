import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/applicant_model.dart';
import '../../services/applicants_service.dart';
import 'cv_preview_modal.dart';
import 'fullscreen_image_preview.dart';

class ApplicantDetailScreen extends ConsumerStatefulWidget {
  final String applicantId;
  final ApplicantModel? initialApplicant;

  const ApplicantDetailScreen({
    super.key,
    required this.applicantId,
    this.initialApplicant,
  });

  @override
  ConsumerState<ApplicantDetailScreen> createState() => _ApplicantDetailScreenState();
}

class _ApplicantDetailScreenState extends ConsumerState<ApplicantDetailScreen> {
  final ApplicantsService _applicantsService = ApplicantsService();
  ApplicantModel? _applicant;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialApplicant != null) {
      _applicant = widget.initialApplicant;
    } else {
      _fetchApplicant();
    }
  }

  Future<void> _fetchApplicant() async {
    setState(() => _isLoading = true);
    final applicant = await _applicantsService.getApplicantById(widget.applicantId);
    if (mounted) {
      setState(() {
        _applicant = applicant;
        _isLoading = false;
      });
    }
  }

  Future<void> _launchCall(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot launch phone call to $phone')),
        );
      }
    }
  }

  Future<void> _launchWhatsApp(String whatsapp) async {
    final cleanPhone = whatsapp.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No WhatsApp number available')),
        );
      }
      return;
    }
    final uri = Uri.parse('https://wa.me/$cleanPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cannot open WhatsApp for $whatsapp')),
        );
      }
    }
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    FullscreenImagePreview.show(context, imagePath: imagePath);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_applicant == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(loc['no_data']),
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F172A),
        ),
        body: Center(
          child: Text(loc['no_data']),
        ),
      );
    }

    final applicant = _applicant!;
    final heroImg = applicant.heroImage ?? applicant.photoUrl ?? 'assets/images/candidate_kamara_hero.jpg';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Candidate Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Hero Image with Back Button Overlay
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 290,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2E8F0),
                      ),
                      child: Image.asset(
                        heroImg,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFF1D4ED8),
                          child: const Center(
                            child: Text(
                              'DW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Top Back Button
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: isRtl ? null : 16,
                      right: isRtl ? 16 : null,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isRtl ? Icons.arrow_forward : Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Overlapping Floating Profile Name & Profession Card
                Transform.translate(
                  offset: const Offset(0, -22),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            applicant.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.work_outline,
                                size: 16,
                                color: Color(0xFFD97706),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  applicant.profession,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64748B),
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

                // Main Details Form Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title: Personal Information
                      Text(
                        loc['personal_information'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Full name Card
                      _buildFieldCard(
                        label: loc['full_name'],
                        value: applicant.name,
                      ),
                      const SizedBox(height: 12),

                      // Phone Card
                      _buildFieldCard(
                        label: loc['phone_label'],
                        value: applicant.phone,
                        onTap: () => _launchCall(applicant.phone),
                        trailingIcon: Icons.phone_forwarded,
                        widthFraction: 0.65,
                      ),
                      const SizedBox(height: 12),

                      // Email Card
                      _buildFieldCard(
                        label: loc['email_label'],
                        value: applicant.email,
                      ),
                      const SizedBox(height: 12),

                      // Row: Age & Nationality
                      Row(
                        children: [
                          Expanded(
                            child: _buildFieldCard(
                              label: loc['age'],
                              value: '${applicant.age}',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFieldCard(
                              label: loc['nationality'],
                              value: applicant.nationality,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Years of Experience Card
                      _buildFieldCard(
                        label: loc['years_of_experience'],
                        value: '${applicant.experienceYears}',
                        widthFraction: 0.65,
                      ),
                      const SizedBox(height: 12),

                      // Job title Card
                      _buildFieldCard(
                        label: loc['job_title'],
                        value: applicant.profession,
                      ),
                      const SizedBox(height: 20),

                      // Section Title: Short bio
                      Text(
                        loc['short_bio'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Short Bio Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Text(
                          applicant.bio,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.45,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Section Title: Certificates / Attachments
                      Text(
                        loc['certificates_attachments'],
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Certificates / Attachments Card matching Screenshot 1
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row: Certificate Badge Icon, Filename, Size & Preview Button
                            Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3C7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.workspace_premium,
                                    color: Color(0xFFD97706),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '4550269f-d7bd-4486-a...',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '476 KB',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF94A3B8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFFD97706),
                                    side: const BorderSide(color: Color(0xFFD97706)),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    final previewImg = applicant.attachmentImages.isNotEmpty
                                        ? applicant.attachmentImages.first
                                        : heroImg;
                                    FullscreenImagePreview.show(
                                      context,
                                      imagePath: previewImg,
                                      title: loc['preview'],
                                    );
                                  },
                                  icon: const Icon(Icons.remove_red_eye_outlined, size: 15),
                                  label: Text(
                                    loc['preview'],
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Embedded Image Preview Banner matching Screenshot 1
                            InkWell(
                              onTap: () {
                                final previewImg = applicant.attachmentImages.isNotEmpty
                                    ? applicant.attachmentImages.first
                                    : heroImg;
                                FullscreenImagePreview.show(
                                  context,
                                  imagePath: previewImg,
                                  title: loc['preview'],
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    applicant.attachmentImages.isNotEmpty
                                        ? applicant.attachmentImages.first
                                        : heroImg,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorBuilder: (_, __, ___) => const Center(
                                      child: Icon(Icons.broken_image, size: 40, color: Color(0xFF94A3B8)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // If candidate has additional attachments
                      if (applicant.attachmentImages.length > 1) ...[
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: applicant.attachmentImages.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (ctx, index) {
                              final img = applicant.attachmentImages[index];
                              return InkWell(
                                onTap: () => FullscreenImagePreview.show(context, imagePath: img),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(img, fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Resume (CV) Card with Preview Button
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.description_outlined,
                                color: Color(0xFF1D4ED8),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc['resume_cv'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    applicant.resumeFileName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1D4ED8),
                                side: const BorderSide(color: Color(0xFF1D4ED8)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => CvPreviewModal.show(context, applicant),
                              icon: const Icon(Icons.remove_red_eye_outlined, size: 16),
                              label: Text(
                                loc['preview'],
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pinned Floating Action Bar at the Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 14,
                bottom: MediaQuery.of(context).padding.bottom + 12,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Call Pill (Warm Orange)
                  _buildPillActionButton(
                    icon: const Icon(Icons.call_rounded, color: Colors.white, size: 22),
                    color: const Color(0xFFEA580C),
                    gradientColors: const [Color(0xFFF97316), Color(0xFFEA580C)],
                    tooltip: loc['call_now'],
                    onTap: () => _launchCall(applicant.phone),
                  ),
                  const SizedBox(width: 12),

                  // WhatsApp Pill (WhatsApp Green)
                  _buildPillActionButton(
                    icon: const _WhatsAppBubbleIcon(size: 24),
                    color: const Color(0xFF16A34A),
                    gradientColors: const [Color(0xFF22C55E), Color(0xFF16A34A)],
                    tooltip: 'WhatsApp',
                    onTap: () => _launchWhatsApp(
                      applicant.whatsapp.isNotEmpty ? applicant.whatsapp : applicant.phone,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // In-App Chat Pill (Direct Work Royal Blue)
                  _buildPillActionButton(
                    icon: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 22),
                    color: AppColors.primary,
                    gradientColors: const [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    tooltip: loc['chat_now'],
                    onTap: () {
                      context.push(
                        '/chat/${applicant.id}?name=${Uri.encodeComponent(applicant.name)}&role=${Uri.encodeComponent(applicant.profession)}',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldCard({
    required String label,
    required String value,
    VoidCallback? onTap,
    IconData? trailingIcon,
    double? widthFraction,
  }) {
    final cardWidget = Container(
      width: widthFraction != null ? null : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: widthFraction != null ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Expanded(
            flex: widthFraction != null ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            Icon(trailingIcon, size: 16, color: const Color(0xFF1D4ED8)),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: cardWidget,
      );
    }
    return cardWidget;
  }

  Widget _buildPillActionButton({
    required Widget icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
    List<Color>? gradientColors,
  }) {
    return Expanded(
      child: Tooltip(
        message: tooltip,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            gradient: gradientColors != null
                ? LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: gradientColors == null ? color : null,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}

class _WhatsAppBubbleIcon extends StatelessWidget {
  final double size;
  const _WhatsAppBubbleIcon({this.size = 24});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.chat_bubble,
            size: size,
            color: Colors.white,
          ),
          Positioned(
            top: size * 0.16,
            child: Icon(
              Icons.phone,
              size: size * 0.52,
              color: const Color(0xFF16A34A),
            ),
          ),
        ],
      ),
    );
  }
}

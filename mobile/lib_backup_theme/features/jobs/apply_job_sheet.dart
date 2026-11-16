import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/job_application_model.dart';
import '../../providers/applications_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';

class ApplyJobSheet extends ConsumerStatefulWidget {
  final String jobId;
  final String jobTitle;

  const ApplyJobSheet({
    super.key,
    required this.jobId,
    required this.jobTitle,
  });

  @override
  ConsumerState<ApplyJobSheet> createState() => _ApplyJobSheetState();
}

class _ApplyJobSheetState extends ConsumerState<ApplyJobSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  final TextEditingController _noteController = TextEditingController();

  String? _selectedFileName;
  String? _selectedFilePath;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    _nameController = TextEditingController(text: user?.fullName ?? '');
    _phoneController = TextEditingController(text: user?.phone.replaceAll('+965 ', '') ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickCvFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFileName = result.files.first.name;
          _selectedFilePath = result.files.first.path;
        });
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.translate('cv_pick_error_msg'))),
        );
      }
    }
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    setState(() => _isSubmitting = true);
    final success = await ref.read(jobsProvider.notifier).apply(
      widget.jobId,
      _nameController.text.trim(),
      _phoneController.text.trim(),
      cvPath: _selectedFilePath,
      note: _noteController.text.trim(),
    );

    if (success) {
      ref.read(applicationsProvider.notifier).addApplication(
        JobApplicationModel(
          id: 'app_${DateTime.now().millisecondsSinceEpoch}',
          jobId: widget.jobId,
          jobTitle: widget.jobTitle,
          companyName: 'جهة العمل في الكويت',
          governorateName: 'دولة الكويت',
          whatsappNumber: '96599112233',
          phoneNumber: '+965 22445566',
          applicantName: _nameController.text.trim(),
          applicantPhone: '+965 ${_phoneController.text.trim()}',
          cvPath: _selectedFileName ?? _selectedFilePath,
          note: _noteController.text.trim(),
          status: 'submitted',
          appliedAt: DateTime.now(),
        ),
      );
    }
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    Navigator.pop(context);
    final prefix = l10n.translate('apply_success_prefix');
    final suffix = l10n.translate('apply_success_suffix');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        content: Text('$prefix "${widget.jobTitle}" $suffix'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.isArabic ? 'التقديم المباشر على الوظيفة' : 'Direct Job Application',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.jobTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 18),

              // Name
              AppTextField(
                controller: _nameController,
                label: l10n.translate('full_name'),
                hint: l10n.isArabic ? 'أحمد الكندري' : 'Ahmed Al-Kandari',
                prefixIcon: Icons.person_outline,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? (l10n.isArabic ? 'يرجى إدخال الاسم' : 'Please enter your name')
                    : null,
              ),
              const SizedBox(height: 12),

              // Phone with Kuwait Country Code
              AppTextField(
                controller: _phoneController,
                label: l10n.translate('phone'),
                hint: '9XXXXXXX / 6XXXXXXX / 5XXXXXXX',
                prefixWidget: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🇰🇼', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 6),
                      Text('+965', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      SizedBox(width: 6),
                      SizedBox(height: 20, child: VerticalDivider(width: 1, color: AppColors.border)),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.trim().length < 8)
                    ? (l10n.isArabic ? 'يرجى إدخال رقم كويتي صحيح (8 أرقام)' : 'Please enter a valid Kuwait phone number (8 digits)')
                    : null,
              ),
              const SizedBox(height: 14),

              // CV Upload Button / File Indicator
              Text(
                l10n.translate('cv_resume'),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: _pickCvFile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedFileName != null ? AppColors.primaryLight : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedFileName != null ? AppColors.primary : AppColors.border,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _selectedFileName != null ? Icons.description : Icons.upload_file,
                        color: _selectedFileName != null ? AppColors.primaryDark : AppColors.textMuted,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedFileName ?? (l10n.isArabic ? 'ارفع سيرتك الذاتية (PDF أو Word)' : 'Upload CV (PDF or Word)'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: _selectedFileName != null ? FontWeight.bold : FontWeight.normal,
                            color: _selectedFileName != null ? AppColors.primaryDark : AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_selectedFileName != null)
                        IconButton(
                          icon: const Icon(Icons.close, size: 18, color: AppColors.error),
                          onPressed: () => setState(() {
                            _selectedFileName = null;
                            _selectedFilePath = null;
                          }),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Note
              AppTextField(
                controller: _noteController,
                label: l10n.isArabic ? 'ملاحظة أو رسالة لصاحب العمل (اختياري)' : 'Note for employer (optional)',
                hint: l10n.isArabic
                    ? 'أنا متاح للعمل فوراً وإقامتي قابلة للتحويل مادة 18...'
                    : 'Available immediately, transferable visa Article 18...',
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // Submit Button
              AppButton(
                text: l10n.isArabic ? 'إرسال طلب التوظيف الآن' : 'Submit Application Now',
                isLoading: _isSubmitting,
                onPressed: _submitApplication,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

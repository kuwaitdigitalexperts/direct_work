import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/kuwait_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/utils/app_preferences.dart';
import '../../models/job_application_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/applications_provider.dart';
import '../../providers/application_pricing_provider.dart';

class AttachedFileItem {
  final String name;
  final String? path;
  final int? sizeBytes;
  final String extension;

  const AttachedFileItem({
    required this.name,
    this.path,
    this.sizeBytes,
    required this.extension,
  });

  String get formattedSize {
    if (sizeBytes == null || sizeBytes! <= 0) return '';
    if (sizeBytes! < 1024) return '$sizeBytes B';
    if (sizeBytes! < 1024 * 1024) return '${(sizeBytes! / 1024).toStringAsFixed(1)} KB';
    return '${(sizeBytes! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class JobApplicationFormScreen extends ConsumerStatefulWidget {
  final String sectorCode;
  final String sectorTitle;
  final String profession;
  final String locationType; // 'inside', 'outside', or 'part_time'

  const JobApplicationFormScreen({
    super.key,
    required this.sectorCode,
    required this.sectorTitle,
    required this.profession,
    this.locationType = 'inside',
  });

  @override
  ConsumerState<JobApplicationFormScreen> createState() => _JobApplicationFormScreenState();
}

class _JobApplicationFormScreenState extends ConsumerState<JobApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  late TextEditingController _experienceController;
  late TextEditingController _bioController;

  String? _selectedGovernorate;
  String? _selectedNationality;

  AttachedFileItem? _attachedCv;
  AttachedFileItem? _savedHomeCv;
  bool _useSavedCv = false;

  final List<AttachedFileItem> _attachedCertificates = [];

  bool _isSubmitting = false;
  String _selectedPaymentMethod = 'knet'; // 'knet', 'credit_card', 'apple_pay'

  // Validation regular expressions
  static final RegExp _nameRegExp = RegExp(r"^[\u0600-\u06FFa-zA-Z\s\.\'-]{3,60}$");
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );
  static final RegExp _kuwaitPhoneRegExp = RegExp(r'^[569]\d{7}$');
  static final RegExp _intlPhoneRegExp = RegExp(r'^[0-9]{7,15}$');

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;

    _fullNameController = TextEditingController(text: user?.fullName ?? '');
    _phoneController = TextEditingController(
      text: user?.phone.replaceAll('+965', '').replaceAll(RegExp(r'[^0-9]'), '').trim() ?? '',
    );
    _emailController = TextEditingController(text: user?.email ?? '');
    _ageController = TextEditingController(text: '');
    _experienceController = TextEditingController(text: '');
    _bioController = TextEditingController(text: '');

    if (user != null && user.governorate != null && user.governorate!.isNotEmpty) {
      final uGov = user.governorate!.trim().toLowerCase();
      final match = KuwaitData.governorates.firstWhere(
        (g) {
          final ar = (g['name_ar'] ?? '').toLowerCase();
          final en = (g['name_en'] ?? '').toLowerCase();
          final id = (g['id'] ?? '').toLowerCase();
          return ar == uGov || en == uGov || id == uGov || en.contains(uGov) || uGov.contains(en) || uGov.contains(id);
        },
        orElse: () => {},
      );
      if (match.isNotEmpty && match['name_en'] != null) {
        _selectedGovernorate = match['name_en'];
      }
    }
    if (user != null && user.nationality != null && user.nationality!.isNotEmpty) {
      final uNat = user.nationality!.trim().toLowerCase();
      final match = KuwaitData.nationalities.firstWhere(
        (n) {
          final en = (n['name_en'] ?? '').toLowerCase();
          final ar = n['name_ar'] ?? '';
          final id = (n['id'] ?? '').toLowerCase();
          return en == uNat || ar == user.nationality || id == uNat || (en.isNotEmpty && uNat.contains(en)) || (en.isNotEmpty && en.contains(uNat));
        },
        orElse: () => {},
      );
      if (match.isNotEmpty && match['name_en'] != null) {
        _selectedNationality = match['name_en'];
      }
    }

    _bioController.addListener(() {
      setState(() {});
    });

    _checkSavedHomeCv();
  }

  Future<void> _checkSavedHomeCv() async {
    try {
      final savedName = await AppPreferences.getString('user_saved_cv_name');
      final savedPath = await AppPreferences.getString('user_saved_cv_path');
      if (savedName != null && savedName.isNotEmpty && mounted) {
        final ext = savedName.contains('.') ? savedName.split('.').last.toLowerCase() : 'pdf';
        setState(() {
          _savedHomeCv = AttachedFileItem(
            name: savedName,
            path: savedPath,
            extension: ext,
          );
          _attachedCv = _savedHomeCv;
          _useSavedCv = true;
        });
      }
    } catch (_) {}
  }

  Future<void> _pickCv() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null && result.files.isNotEmpty) {
        final f = result.files.first;
        setState(() {
          _attachedCv = AttachedFileItem(
            name: f.name,
            path: f.path,
            sizeBytes: f.size,
            extension: f.extension?.toLowerCase() ?? 'pdf',
          );
          _useSavedCv = false;
        });
        await AppPreferences.setString('user_saved_cv_name', f.name);
        if (f.path != null) {
          await AppPreferences.setString('user_saved_cv_path', f.path!);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting CV: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _pickCertificates() async {
    if (_attachedCertificates.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).isArabic
                ? 'الحد الأقصى للشهادات هو 5 شهادات'
                : 'Maximum 5 certificates allowed',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          for (final f in result.files) {
            if (_attachedCertificates.length >= 5) break;
            final exists = _attachedCertificates.any((c) => c.name == f.name);
            if (!exists) {
              _attachedCertificates.add(
                AttachedFileItem(
                  name: f.name,
                  path: f.path,
                  sizeBytes: f.size,
                  extension: f.extension?.toLowerCase() ?? 'pdf',
                ),
              );
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting certificate: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // --- Strict Field Validators ---

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Name must be at least 3 characters';
    }
    if (!_nameRegExp.hasMatch(trimmed)) {
      return 'Please enter a valid name (letters only)';
    }
    return null;
  }

  String? _validatePhone(String? value, bool isInside) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (isInside) {
      if (digits.length != 8 || !_kuwaitPhoneRegExp.hasMatch(digits)) {
        return 'Enter valid 8-digit Kuwait number starting with 5, 6, or 9';
      }
    } else {
      if (digits.length < 7 || digits.length > 15 || !_intlPhoneRegExp.hasMatch(digits)) {
        return 'Enter valid international phone number (7-15 digits)';
      }
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    final trimmed = value.trim();
    if (!_emailRegExp.hasMatch(trimmed)) {
      return 'Please enter a valid email address (e.g. name@domain.com)';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'Enter a valid number';
    }
    if (age < 18) {
      return 'Applicant must be at least 18 years old';
    }
    if (age > 65) {
      return 'Age must be 65 or below';
    }
    return null;
  }

  String? _validateExperience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Years of experience is required';
    }
    final exp = int.tryParse(value.trim());
    if (exp == null) {
      return 'Enter a valid number';
    }
    if (exp < 0 || exp > 45) {
      return 'Experience must be between 0 and 45 years';
    }
    return null;
  }

  String? _validateBio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Short bio is required';
    }
    final trimmed = value.trim();
    if (trimmed.length < 20) {
      return 'Bio must be at least 20 characters describing your skills';
    }
    return null;
  }

  // --- Step 1: Validate and Open Payment Flow ---
  void _onProceedToPayment() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final isInside = widget.locationType == 'inside' || widget.locationType == 'part_time';
    if (isInside && (_selectedGovernorate == null || _selectedGovernorate!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a Kuwait governorate'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedNationality == null || _selectedNationality!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your nationality'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Open Payment Checkout Modal
    _showPaymentBottomSheet();
  }

  // --- Step 2: Payment Gateway Checkout Modal ---
  void _showPaymentBottomSheet() {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;
    final now = DateTime.now();
    final expiryDate = now.add(const Duration(days: 90)); // strictly 3 months (90 days)
    const feeKwd = 2.0; // Strictly 2 KWD, no free trial

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(modalContext).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag Handle
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Header: Payment Checkout & SSL Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isArabic ? 'بوابة الدفع الإلكتروني' : 'Kuwait Payment Gateway',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isArabic ? 'دفع آمن ومشفر 256-Bit SSL' : '256-Bit SSL Secure Checkout',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: const [
                              Text('🇰🇼', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 4),
                              Text(
                                'K-Net / Card',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Order Summary Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                            label: isArabic ? 'الخدمة' : 'Service',
                            value: widget.profession,
                            isBold: true,
                          ),
                          const Divider(height: 18, color: Color(0xFFE2E8F0)),
                          _buildSummaryRow(
                            label: isArabic ? 'المدة' : 'Duration',
                            value: isArabic ? '3 أشهر (90 يوماً)' : '3 Months (90 Days)',
                          ),
                          const SizedBox(height: 8),
                          _buildSummaryRow(
                            label: isArabic ? 'فترة الصلاحية' : 'Active Period',
                            value: '${now.day}/${now.month}/${now.year} → ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}',
                          ),
                          const SizedBox(height: 8),
                          _buildSummaryRow(
                            label: isArabic ? 'الحذف التلقائي' : 'Auto-Removal',
                            value: isArabic ? 'بعد 3 أشهر تلقائياً' : 'After 90 Days',
                          ),
                          const Divider(height: 18, color: Color(0xFFE2E8F0)),
                          _buildSummaryRow(
                            label: isArabic ? 'المبلغ الإجمالي' : 'Total Amount',
                            value: '${feeKwd.toStringAsFixed(3)} KWD',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Payment Method Selection
                    Text(
                      isArabic ? 'اختر وسيلة الدفع' : 'Select Payment Method',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 1. K-Net (Recommended in Kuwait)
                    _buildPaymentMethodTile(
                      id: 'knet',
                      title: isArabic ? 'كي نت (K-Net بطاقة سحب آلي)' : 'K-Net (Kuwait Debit Card)',
                      subtitle: isArabic ? 'البطاقة الوطنية الأكثر استخداماً داخل الكويت' : 'Instant bank debit card for all Kuwait banks',
                      icon: Icons.account_balance,
                      badgeText: isArabic ? 'موصى به' : 'Recommended',
                      isSelected: _selectedPaymentMethod == 'knet',
                      onSelect: () => setModalState(() => _selectedPaymentMethod = 'knet'),
                    ),
                    const SizedBox(height: 10),

                    // 2. Visa / MasterCard
                    _buildPaymentMethodTile(
                      id: 'credit_card',
                      title: isArabic ? 'بطاقة ائتمان (فيزا / ماستركارد)' : 'Credit Card (Visa / Mastercard)',
                      subtitle: isArabic ? 'الدفع بالبطاقات الائتمانية الدولية والمحلية' : 'Kuwait & International credit cards',
                      icon: Icons.credit_card,
                      isSelected: _selectedPaymentMethod == 'credit_card',
                      onSelect: () => setModalState(() => _selectedPaymentMethod = 'credit_card'),
                    ),
                    const SizedBox(height: 10),

                    // 3. Apple Pay
                    _buildPaymentMethodTile(
                      id: 'apple_pay',
                      title: 'Apple Pay',
                      subtitle: isArabic ? 'دفع سريع وآمن بلمسة واحدة' : 'Quick one-touch secure payment',
                      icon: Icons.phone_iphone,
                      isSelected: _selectedPaymentMethod == 'apple_pay',
                      onSelect: () => setModalState(() => _selectedPaymentMethod = 'apple_pay'),
                    ),
                    const SizedBox(height: 22),

                    // Action: Pay Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 2,
                        ),
                        onPressed: () {
                          Navigator.of(modalContext).pop();
                          _executePaymentAndSubmit(feeKwd, _selectedPaymentMethod);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock_outline, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              isArabic
                                  ? 'دفع رسوم الطلب ${feeKwd.toStringAsFixed(0)} د.ك عبر ${_getMethodName(_selectedPaymentMethod, isArabic)}'
                                  : 'Pay ${feeKwd.toStringAsFixed(0)} KWD via ${_getMethodName(_selectedPaymentMethod, isArabic)}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        isArabic
                          ? 'سيتم تفعيل الإعلان فور إتمام عملية الدفع وصلاحيته 3 أشهر كاملة'
                          : 'Ad activates immediately upon payment confirmation for 3 full months',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getMethodName(String method, bool isArabic) {
    switch (method) {
      case 'knet':
        return 'K-Net';
      case 'credit_card':
        return isArabic ? 'البطاقة الائتمانية' : 'Card';
      case 'apple_pay':
        return 'Apple Pay';
      default:
        return 'K-Net';
    }
  }

  Widget _buildSummaryRow({required String label, required String value, bool isBold = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: isTotal ? 16 : 13,
              fontWeight: isTotal || isBold ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppColors.primary : const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    String? badgeText,
    required bool isSelected,
    required VoidCallback onSelect,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF475569),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? AppColors.primary : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      if (badgeText != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 3: Execute Payment Simulation & Post to API ---
  Future<void> _executePaymentAndSubmit(double feeKwd, String method) async {
    setState(() => _isSubmitting = true);

    // Show simulated gateway transaction sheet
    final txnId = 'KNET-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}-${Random().nextInt(900) + 100}';
    final appliedAt = DateTime.now();
    final expiresAt = appliedAt.add(const Duration(days: 90)); // strictly 3 months (90 days)
    final isInside = widget.locationType == 'inside' || widget.locationType == 'part_time';

    try {
      final apiClient = ApiClient();
      final payload = {
        'profession': widget.profession,
        'sector': widget.sectorCode,
        'sector_title': widget.sectorTitle,
        'location_type': widget.locationType,
        'name': _fullNameController.text.trim(),
        'phone': isInside ? '+965 ${_phoneController.text.trim()}' : _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'governorate': _selectedGovernorate ?? (isInside ? 'Capital' : 'Kuwait'),
        'age': int.tryParse(_ageController.text.trim()) ?? 25,
        'nationality': _selectedNationality ?? 'Kuwaiti',
        'experience_years': int.tryParse(_experienceController.text.trim()) ?? 3,
        'bio': _bioController.text.trim(),
        'cv_path': _attachedCv?.name,
        'photo_path': null,
        'certificates': _attachedCertificates.map((c) => c.name).toList(),
        'duration': '3 months',
        'duration_months': 3,
        'price': '2 KWD',
        'price_kwd': feeKwd,
        'payment_method': method,
        'payment_id': txnId,
        'payment_status': 'paid',
        'applied_at': appliedAt.toIso8601String(),
        'expires_at': expiresAt.toIso8601String(),
      };

      // Call Backend API
      await apiClient.dio.post(ApiEndpoints.applications, data: payload);

      // Create model for local provider state with expiration
      final newApp = JobApplicationModel(
        id: 'app_${DateTime.now().millisecondsSinceEpoch}',
        jobId: 'job_${widget.sectorCode}',
        jobTitle: widget.profession,
        companyName: isInside ? 'Direct Work Kuwait' : 'Outside Kuwait Talent Pool',
        governorateName: _selectedGovernorate ?? 'Kuwait',
        whatsappNumber: _phoneController.text.trim(),
        phoneNumber: isInside ? '+965 ${_phoneController.text.trim()}' : _phoneController.text.trim(),
        applicantName: _fullNameController.text.trim(),
        applicantPhone: isInside ? '+965 ${_phoneController.text.trim()}' : _phoneController.text.trim(),
        cvPath: _attachedCv?.name,
        note: _bioController.text.trim(),
        status: 'active',
        appliedAt: appliedAt,
        expiresAt: expiresAt,
        paymentId: txnId,
        priceKwd: feeKwd,
      );

      ref.read(applicationsProvider.notifier).addApplication(newApp);

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      _showSuccessDialog(txnId, expiresAt);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      final l10n = AppLocalizations.of(context);
      final isArabic = l10n.isArabic;
      String errorMsg;
      if (e.toString().contains('connection timeout') ||
          e.toString().contains('receive timeout') ||
          e.toString().contains('connection error') ||
          e.toString().contains('SocketException')) {
        errorMsg = isArabic
            ? 'تعذر الاتصال بالخادم. يرجى التحقق من اتصال الإنترنت والمحاولة مجدداً.'
            : 'Connection error. Please check your internet connection and try again.';
      } else {
        errorMsg = isArabic
            ? 'خطأ في إرسال الطلب: $e'
            : 'Submission error: $e';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccessDialog(String txnId, DateTime expiresAt) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFECFDF5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 44),
            ),
            const SizedBox(height: 12),
            Text(
              isArabic ? 'تم تأكيد الدفع والتقديم بنجاح!' : 'Payment & Application Confirmed!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isArabic
                  ? 'تم استلام الرسوم بقيمة 2 د.ك وإضافة إعلانك في قطاع (${widget.sectorTitle}). إعلانك مرئي لأصحاب العمل لمدة 3 أشهر كاملة.'
                  : 'Fee of 2 KWD received and your profile is now active in ${widget.sectorTitle}. Your ad is visible to employers for 3 full months.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.4),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? 'رقم الإيصال:' : 'Ref ID:',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                      Text(
                        txnId,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? 'تاريخ الانتهاء:' : 'Valid Until:',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                      Text(
                        '${expiresAt.day}/${expiresAt.month}/${expiresAt.year} (90 days)',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go('/home');
                  },
                  child: Text(isArabic ? 'الرئيسية' : 'Home'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.push('/my-applications');
                  },
                  child: Text(
                    isArabic ? 'طلباتي' : 'My Applications',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = l10n.isArabic;
    final isInside = widget.locationType == 'inside' || widget.locationType == 'part_time';

    final charsRemaining = (200 - _bioController.text.length).clamp(0, 200);

    final validGovs = KuwaitData.governorates.map((g) => g['name_en']).toSet();
    final safeGovValue = validGovs.contains(_selectedGovernorate) ? _selectedGovernorate : null;

    final validNats = KuwaitData.nationalities.map((n) => n['name_en']).toSet();
    final safeNatValue = validNats.contains(_selectedNationality) ? _selectedNationality : null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          widget.profession,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Badge & Subtitle
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.locationType == 'part_time'
                          ? (isArabic ? 'دوام جزئي' : 'Part-Time')
                          : (isInside ? (isArabic ? 'داخل الكويت' : 'Inside Kuwait') : (isArabic ? 'خارج الكويت' : 'Outside Kuwait')),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.sectorTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Instruction Subtitle
              Text(
                l10n.translate('fill_details_subtitle'),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),

              // CARD 1: Personal Information
              _buildCardContainer(
                title: l10n.translate('personal_information'),
                trailingIcon: Icons.person_outline,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    _buildLabel(l10n.translate('full_name')),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _fullNameController,
                      validator: _validateFullName,
                      decoration: _inputDecoration(hint: isArabic ? 'مثال: محمد أحمد الصباح' : 'e.g. Asim Khalid'),
                    ),
                    const SizedBox(height: 14),

                    // Governorate (Shown ONLY if inside Kuwait / Part-time)
                    if (isInside) ...[
                      _buildLabel(l10n.translate('governorate_required')),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: safeGovValue,
                        hint: Text(
                          l10n.translate('select_governorate'),
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                        validator: (val) => val == null || val.isEmpty ? 'Governorate is required' : null,
                        items: KuwaitData.governorates.map((gov) {
                          final name = isArabic ? gov['name_ar']! : gov['name_en']!;
                          return DropdownMenuItem<String>(
                            value: gov['name_en'],
                            child: Text(name, style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedGovernorate = val),
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Phone Number
                    _buildLabel(l10n.translate('phone_number')),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (val) => _validatePhone(val, isInside),
                            decoration: _inputDecoration(
                              hint: isInside ? '8 digits (e.g. 98765432)' : 'Phone with country code',
                              prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary, size: 18),
                            ),
                          ),
                        ),
                        if (isInside) ...[
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFFBFDBFE)),
                            ),
                            child: Row(
                              children: const [
                                Text('🇰🇼', style: TextStyle(fontSize: 16)),
                                SizedBox(width: 6),
                                Text(
                                  '+965',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Email Address
                    _buildLabel(l10n.translate('email_address')),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      decoration: _inputDecoration(
                        hint: 'e.g. user@gmail.com',
                        prefixIcon: const Icon(Icons.mail_outline, color: AppColors.primary, size: 18),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2-Column: Age & Nationality
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Age
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('${l10n.translate('age')} *'),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _ageController,
                                keyboardType: TextInputType.number,
                                validator: _validateAge,
                                decoration: _inputDecoration(hint: '18 - 65'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Nationality
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('${l10n.translate('nationality')} *'),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: safeNatValue,
                                isExpanded: true,
                                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                                hint: Text(
                                  l10n.translate('choose_nationality'),
                                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: KuwaitData.nationalities.map((nat) {
                                  final name = isArabic ? nat['name_ar']! : nat['name_en']!;
                                  return DropdownMenuItem<String>(
                                    value: nat['name_en'],
                                    child: Text(name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() => _selectedNationality = val),
                                decoration: _inputDecoration(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // CARD 2: Experience & Bio
              _buildCardContainer(
                title: l10n.translate('experience_and_bio'),
                trailingIcon: Icons.work_outline,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('${l10n.translate('years_of_experience')} *'),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _experienceController,
                      keyboardType: TextInputType.number,
                      validator: _validateExperience,
                      decoration: _inputDecoration(hint: 'e.g. 5'),
                    ),
                    const SizedBox(height: 14),

                    _buildLabel('${l10n.translate('short_bio_text')} *'),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _bioController,
                      maxLines: 4,
                      maxLength: 200,
                      validator: _validateBio,
                      buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                      decoration: _inputDecoration(
                        hint: isArabic
                            ? 'صف خبراتك ومهاراتك بإيجاز (20 حرف كحد أدنى)...'
                            : 'Briefly describe your skills and experience (min 20 chars)...',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        '$charsRemaining ${l10n.translate('characters_remaining')}',
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // CARD 3: Attachments
              _buildCardContainer(
                title: isArabic ? 'المرفقات والسيرة الذاتية' : 'Attachments & Documents',
                trailingIcon: Icons.attach_file_rounded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CV SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel(isArabic ? 'السيرة الذاتية (CV / Resume)' : 'Resume / CV (Optional)'),
                        if (_attachedCv != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECFDF5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.check_circle, size: 12, color: Color(0xFF10B981)),
                                const SizedBox(width: 4),
                                Text(
                                  isArabic ? 'تم الإرفاق' : 'Attached',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isArabic
                          ? 'أرفق سيرتك الذاتية بصيغة PDF أو Word ليتمكن أصحاب العمل في دولة الكويت من التواصل معك.'
                          : 'Attach your CV in PDF or Word format so Kuwait employers can view your qualifications.',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.3),
                    ),
                    const SizedBox(height: 12),

                    // Pre-loaded CV option (from Home screen)
                    if (_savedHomeCv != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _useSavedCv ? const Color(0xFFEFF6FF) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: _useSavedCv ? AppColors.primary : const Color(0xFFE2E8F0),
                            width: _useSavedCv ? 1.5 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: _useSavedCv,
                              activeColor: AppColors.primary,
                              onChanged: (val) {
                                if (val == true) {
                                  setState(() {
                                    _useSavedCv = true;
                                    _attachedCv = _savedHomeCv;
                                  });
                                }
                              },
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _useSavedCv = true;
                                    _attachedCv = _savedHomeCv;
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF10B981).withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            isArabic ? 'سيرتك الذاتية من الرئيسية' : 'Saved from Home',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF10B981),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _savedHomeCv!.name,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (_savedHomeCv!.formattedSize.isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        _savedHomeCv!.formattedSize,
                                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],

                    // Current Attached CV display (if picked or different)
                    if (_attachedCv != null && (!_useSavedCv || _savedHomeCv == null)) ...[
                      _buildCvCard(_attachedCv!),
                      const SizedBox(height: 10),
                    ],

                    // Pick / Replace CV Button
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide(color: AppColors.primary.withOpacity(0.4), width: 1.2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ),
                            onPressed: _pickCv,
                            icon: const Icon(Icons.file_upload_outlined, size: 18),
                            label: Text(
                              _attachedCv != null
                                  ? (isArabic ? 'اختيار ملف سيرة ذاتية آخر' : 'Choose Different CV')
                                  : (isArabic ? 'اختيار السيرة الذاتية (PDF / Word)' : 'Select CV File (PDF / Word)'),
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (_attachedCv != null) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 22),
                            tooltip: isArabic ? 'إزالة السيرة الذاتية' : 'Remove CV',
                            onPressed: () {
                              setState(() {
                                _attachedCv = null;
                                _useSavedCv = false;
                              });
                            },
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 22),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 20),

                    // CERTIFICATES SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabel(isArabic ? 'شهادات الخبرة والدورات التدريبية' : 'Experience & Training Certificates'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${_attachedCertificates.length}/5',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isArabic
                          ? 'أرفق حتى 5 شهادات خبرة أو دورات مهنية (PDF أو صور أو Word) لتعزيز فرص قبول طلبك.'
                          : 'Attach up to 5 certificates or diplomas (PDF, image, or Word) to strengthen your application.',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.3),
                    ),
                    const SizedBox(height: 12),

                    // Certificates List Cards
                    if (_attachedCertificates.isNotEmpty) ...[
                      Column(
                        children: _attachedCertificates.asMap().entries.map((entry) {
                          final idx = entry.key;
                          final cert = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: _buildCertificateCard(
                              cert,
                              onRemove: () => setState(() => _attachedCertificates.removeAt(idx)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 6),
                    ],

                    // Add Certificate Button
                    if (_attachedCertificates.length < 5) ...[
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0F172A),
                            side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          onPressed: _pickCertificates,
                          icon: const Icon(Icons.add_photo_alternate_outlined, size: 18, color: AppColors.primary),
                          label: Text(
                            isArabic ? 'إضافة شهادة من الملفات أو الصور' : 'Add Certificate from Files or Gallery',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // CARD 4: Plan, Validity Duration & Pricing (2 KWD for 2 Months strictly)
              _buildCardContainer(
                title: l10n.translate('ad_visibility_duration'),
                trailingIcon: Icons.timer_outlined,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'إعلان التوظيف (صالحة لـ 3 أشهر)' : 'Job Application (3 Months Validity)',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isArabic
                                  ? 'صالح لمدة 90 يوماً ويتم إزالته تلقائياً بعد 3 أشهر'
                                  : 'Active for 90 days, auto-removed after 3 months',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '2',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              height: 1.1,
                            ),
                          ),
                          Text(
                            isArabic ? 'د.ك' : 'KWD',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Proceed to Payment Button (Royal Blue)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                  ),
                  onPressed: _isSubmitting ? null : _onProceedToPayment,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.payment, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              isArabic
                                  ? 'المتابعة للدفع وتأكيد الطلب (2 د.ك)'
                                  : 'Proceed to Payment (2 KWD)',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContainer({
    required String title,
    required IconData? trailingIcon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, color: AppColors.primary, size: 20),
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, Widget? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red, width: 1.8),
      ),
    );
  }

  Widget _buildCvCard(AttachedFileItem file) {
    final isPdf = file.extension == 'pdf';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isPdf ? const Color(0xFFEF4444) : AppColors.primary).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf : Icons.description,
              color: isPdf ? const Color(0xFFEF4444) : AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      file.extension.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isPdf ? const Color(0xFFEF4444) : AppColors.primary,
                      ),
                    ),
                    if (file.formattedSize.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        '• ${file.formattedSize}',
                        style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(AttachedFileItem cert, {required VoidCallback onRemove}) {
    final ext = cert.extension.toLowerCase();
    final isPdf = ext == 'pdf';
    final isImg = ext == 'jpg' || ext == 'jpeg' || ext == 'png';

    final Color badgeColor = isPdf
        ? const Color(0xFFEF4444)
        : (isImg ? const Color(0xFF8B5CF6) : AppColors.primary);
    final IconData icon = isPdf
        ? Icons.picture_as_pdf
        : (isImg ? Icons.image_outlined : Icons.workspace_premium_outlined);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: badgeColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  cert.formattedSize.isNotEmpty
                      ? '${cert.extension.toUpperCase()} • ${cert.formattedSize}'
                      : cert.extension.toUpperCase(),
                  style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: Color(0xFF94A3B8)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentPill(String name, {required VoidCallback onRemove}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.attach_file, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              name,
              style: const TextStyle(fontSize: 12, color: Color(0xFF1E293B), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/country_config.dart';
import '../../providers/country_provider.dart';
import '../../services/payment_service.dart';
import '../../shared/widgets/app_button.dart';

class MyfatoorahPaymentScreen extends ConsumerStatefulWidget {
  final double amount;
  final String title;

  const MyfatoorahPaymentScreen({
    super.key,
    required this.amount,
    required this.title,
  });

  @override
  ConsumerState<MyfatoorahPaymentScreen> createState() => _MyfatoorahPaymentScreenState();
}

class _MyfatoorahPaymentScreenState extends ConsumerState<MyfatoorahPaymentScreen> {
  final PaymentService _paymentService = PaymentService();
  String _selectedMethod = 'knet';
  bool _isProcessing = false;

  Future<void> _processPayment(AppLocalizations l10n) async {
    final activeCountry = ref.read(countryProvider);
    final currencyText = l10n.isArabic ? activeCountry.currencyAr : activeCountry.currencyEn;
    setState(() => _isProcessing = true);
    final invoice = await _paymentService.processMyFatoorahPayment(
      amountKwd: widget.amount,
      description: widget.title,
      customerName: l10n.isArabic ? 'عميل دايركت وورك ${activeCountry.nameAr}' : 'Direct Work ${activeCountry.nameEn} Customer',
      customerEmail: 'customer@directjobs.${activeCountry.id}',
      paymentMethod: _selectedMethod.toUpperCase(),
    );
    setState(() => _isProcessing = false);

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: AppColors.success, size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.translate('payment_success_title'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '${l10n.translate('invoice_number')}: ${invoice.invoiceId}',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              const SizedBox(height: 12),
              Text(
                '${l10n.translate('amount_paid')}: ${widget.amount} $currencyText (${_selectedMethod.toUpperCase()})',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.translate('payment_success_desc'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(l10n.translate('back_to_home')),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activeCountry = ref.watch(countryProvider);
    final currencyText = l10n.isArabic ? activeCountry.currencyAr : activeCountry.currencyEn;
    final gatewayTitle = activeCountry.id == 'sa'
        ? (l10n.isArabic ? 'بوابة الدفع الإلكتروني المعتمدة (السعودية)' : 'Authorized Saudi Payment Gateway')
        : (activeCountry.id == 'ae'
            ? (l10n.isArabic ? 'بوابة الدفع الإلكتروني (الإمارات)' : 'Authorized UAE Payment Gateway')
            : (l10n.isArabic ? 'بوابة الدفع MyFatoorah (الكويت)' : 'MyFatoorah Payment Gateway'));

    final debitTitle = activeCountry.id == 'sa'
        ? (l10n.isArabic ? 'بطاقة مدى (Mada السعودية)' : 'Mada Debit Card (Saudi Arabia)')
        : (activeCountry.id == 'ae'
            ? (l10n.isArabic ? 'بطاقة خصم مصرفية إماراتية' : 'UAE Bank Debit Card')
            : (l10n.isArabic ? 'بطاقة كي نت (KNET الكويتية)' : 'KNET Debit Card (Kuwait)'));

    final debitSubtitle = activeCountry.id == 'sa'
        ? (l10n.isArabic ? 'شبكة المدفوعات الوطنية السعودية مدى' : 'Direct payment via Saudi debit card')
        : (activeCountry.id == 'ae'
            ? (l10n.isArabic ? 'الدفع المباشر عبر البنوك الإماراتية' : 'Direct debit card payment across UAE')
            : (l10n.isArabic ? 'الدفع المباشر عبر بطاقة الصراف الآلي لجميع بنوك الكويت' : 'Direct ATM debit card for all Kuwaiti banks'));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(gatewayTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.translate('service_package'), style: const TextStyle(color: AppColors.textSecondary)),
                        Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.translate('total_amount'), style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '${widget.amount} $currencyText (${activeCountry.currencyEn})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                l10n.translate('select_payment_method'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              _buildPaymentOption(
                id: 'knet',
                title: debitTitle,
                subtitle: debitSubtitle,
                icon: Icons.account_balance,
              ),
              const SizedBox(height: 10),

              _buildPaymentOption(
                id: 'visa',
                title: l10n.isArabic ? 'بطاقة ائتمان (Visa / Mastercard)' : 'Credit Card (Visa / Mastercard)',
                subtitle: l10n.isArabic
                    ? 'الدفع بالبطاقات الائتمانية الدولية والمحلية'
                    : 'Local and international credit card payment',
                icon: Icons.credit_card,
              ),
              const SizedBox(height: 10),

              _buildPaymentOption(
                id: 'apple_pay',
                title: 'Apple Pay',
                subtitle: l10n.isArabic ? 'الدفع السريع والآمن بلمسة واحدة' : 'Fast and secure 1-touch payment',
                icon: Icons.apple,
              ),

              const Spacer(),

              AppButton(
                text: '${l10n.translate('pay_now')} (${widget.amount} $currencyText)',
                isLoading: _isProcessing,
                onPressed: () => _processPayment(l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedMethod == id;

    return InkWell(
      onTap: () => setState(() => _selectedMethod = id),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

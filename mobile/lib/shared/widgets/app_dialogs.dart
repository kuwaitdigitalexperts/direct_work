import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/countries_data.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/country_config.dart';

enum NoticeDialogType { warning, danger, info }

class AppDialogs {
  /// Top Notice Dialog matching Screenshots 1, 2, and 4
  /// Features a 30-second animated progress bar at the bottom that automatically
  /// counts down and closes the dialog when finished.
  static Future<T?> showTopNoticeDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    NoticeDialogType type = NoticeDialogType.warning,
    required Widget contentActions,
    Duration autoCloseDuration = const Duration(seconds: 30),
    bool showProgress = true,
    Color? progressColor,
    Widget? bottomDecoration,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (ctx) {
        return TopNoticeDialogContent(
          title: title,
          message: message,
          type: type,
          contentActions: contentActions,
          autoCloseDuration: autoCloseDuration,
          showProgress: showProgress,
          progressColor: progressColor,
        );
      },
    );
  }

  /// Inside Application Notice Dialog (supports dynamic country: Kuwait, Saudi, UAE)
  static void showInsideApplicationNotice(BuildContext context, [CountryConfig? country]) {
    final l10n = AppLocalizations.of(context);
    final targetCountry = country ?? CountriesData.kuwait;
    final countryName = l10n.isArabic ? targetCountry.shortNameAr : targetCountry.shortNameEn;
    final phoneCode = targetCountry.phoneCode;

    final title = l10n.isArabic
        ? 'تنبيه التقديم من داخل $countryName'
        : 'Inside $countryName Application Notice';

    final p1 = l10n.isArabic
        ? 'هذا القسم مخصص للباحثين عن عمل المقيمين داخل $countryName برقم هاتف محلي يبدأ بـ ($phoneCode).'
        : 'This section is restricted to job seekers residing inside $countryName with a local phone number starting with ($phoneCode).';

    final p2 = l10n.isArabic
        ? 'نظراً لأن إقامتك الحالية أو رقم هاتفك مسجل خارج $countryName، يمكنك التقديم بسهولة من خلال قسم "خارج $countryName"، أو تحديث ملفك الشخصي إذا كنت تقيم هنا حالياً.'
        : 'As your current residency or phone number is registered outside $countryName, you can easily apply through the \'Outside $countryName\' section, or update your profile if you currently live here.';

    final applyOutsideText = l10n.isArabic ? 'التقديم من الخارج' : 'Apply from Outside';
    final updateProfileText = l10n.isArabic ? 'تحديث الملف الشخصي' : 'Update Profile';
    final cancelText = l10n.isArabic ? 'إلغاء' : 'Cancel';

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (dialogContext) {
        return Dialog(
          alignment: Alignment.topCenter,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Color(0xFFBFDBFE), width: 1.2),
          ),
          backgroundColor: const Color(0xFFEFF6FF),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Header: Icon + Title + Close Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFF1D4ED8),
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(dialogContext).pop(),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D4ED8).withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Paragraph 1
                Text(
                  p1,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.45,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 14),

                // Paragraph 2
                Text(
                  p2,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 18),

                // Action Buttons Row 1: Apply from Outside & Update Profile
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.push('/select-sector?locationType=outside');
                        },
                        child: Text(
                          applyOutsideText,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          context.push('/profile');
                        },
                        child: Text(
                          updateProfileText,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Row 2: Cancel button (left-aligned)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1D4ED8),
                      side: const BorderSide(color: Color(0xFFBFDBFE), width: 1.2),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      cancelText,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Available Soon Top Notice Toast (Screenshot 2)
  static void showAvailableSoonTopNotice(
    BuildContext context, {
    String? message,
  }) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.isArabic ? 'متاح قريباً' : 'Available Soon';
    final desc = message ??
        (l10n.isArabic
            ? 'قسم الإعلانات التجارية سيكون متاحاً قريباً. ترقبونا!'
            : 'Commercial Ads will be available soon. Stay tuned!');

    showTopNoticeDialog(
      context: context,
      title: title,
      message: desc,
      type: NoticeDialogType.warning,
      autoCloseDuration: const Duration(seconds: 30),
      showProgress: true,
      contentActions: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.isArabic ? 'حسناً' : 'OK',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// Available Soon Centered Lock Card (Screenshot 3)
  static Widget buildAvailableSoonCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Blue Circular Lock Icon Badge
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 34,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              l10n.isArabic ? 'متاح قريباً' : 'Available Soon',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              l10n.isArabic
                  ? 'قسم الإعلانات التجارية سيكون متاحاً في الإصدار القادم. ترقبونا!'
                  : 'The commercial ads section will be available soon. Stay tuned!',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Log Out Dialog (Screenshot 4)
  static void showLogoutDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.isArabic ? 'تسجيل الخروج' : 'Log out';
    final message = l10n.isArabic
        ? 'هل ترغب بالفعل في تسجيل الخروج؟'
        : 'Are you sure you want to log out?';

    showTopNoticeDialog(
      context: context,
      title: title,
      message: message,
      type: NoticeDialogType.danger,
      contentActions: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF475569),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              l10n.translate('cancel'),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB91C1C),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(
              l10n.isArabic ? 'تسجيل الخروج' : 'Log out',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Delete Account Notice Dialog
  static void showDeleteAccountDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.isArabic ? 'حذف الحساب نهائياً' : 'Delete Account';
    final message = l10n.isArabic
        ? 'هل أنت متأكد من رغبتك في حذف الحساب نهائياً؟ لا يمكن التراجع عن هذا الإجراء.'
        : 'Are you sure you want to delete your account permanently? This action cannot be undone.';

    showTopNoticeDialog(
      context: context,
      title: title,
      message: message,
      type: NoticeDialogType.danger,
      contentActions: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF475569),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              l10n.translate('cancel'),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(
              l10n.isArabic ? 'حذف نهائي' : 'Delete Permanently',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class TopNoticeDialogContent extends StatefulWidget {
  final String title;
  final String message;
  final NoticeDialogType type;
  final Widget contentActions;
  final Duration autoCloseDuration;
  final bool showProgress;
  final Color? progressColor;

  const TopNoticeDialogContent({
    super.key,
    required this.title,
    required this.message,
    this.type = NoticeDialogType.warning,
    required this.contentActions,
    this.autoCloseDuration = const Duration(seconds: 30),
    this.showProgress = true,
    this.progressColor,
  });

  @override
  State<TopNoticeDialogContent> createState() => _TopNoticeDialogContentState();
}

class _TopNoticeDialogContentState extends State<TopNoticeDialogContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.autoCloseDuration,
    );

    if (widget.showProgress && widget.autoCloseDuration.inMilliseconds > 0) {
      _controller.forward();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDanger = widget.type == NoticeDialogType.danger;
    final bgColor = isDanger ? const Color(0xFFFEF2F2) : const Color(0xFFFFFBEB);
    final borderColor = isDanger ? const Color(0xFFFECACA) : const Color(0xFFFDE68A);
    final iconColor = isDanger ? const Color(0xFFDC2626) : const Color(0xFFD97706);
    final iconBgColor = isDanger ? const Color(0xFFFEE2E2) : const Color(0xFFFEF3C7);
    final barColor = widget.progressColor ?? AppColors.primary;

    return Dialog(
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 34),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor, width: 1.2),
      ),
      backgroundColor: bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row: Icon + Title + Close Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isDanger ? Icons.error_outline_rounded : Icons.warning_amber_rounded,
                        color: iconColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 18,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Body Message
                Text(
                  widget.message,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 16),

                // Action Buttons
                widget.contentActions,
              ],
            ),
          ),

          // Animated 30-Second Countdown Progress Bar
          if (widget.showProgress)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: (1.0 - _controller.value).clamp(0.0, 1.0),
                  minHeight: 4.0,
                  backgroundColor: Colors.black.withOpacity(0.06),
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                );
              },
            ),
        ],
      ),
    );
  }
}

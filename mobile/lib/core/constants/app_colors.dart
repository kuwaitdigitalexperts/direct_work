import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Direct Work Premium Royal Blue Palette)
  static const Color primary = Color(0xFF1D4ED8);       // Modern Royal Blue
  static const Color primaryDark = Color(0xFF1E3A8A);   // Deep Navy Sapphire
  static const Color primaryDeep = Color(0xFF0F172A);   // Rich Midnight Slate Blue
  static const Color primaryAccent = Color(0xFF2563EB); // Vibrant Accent Blue
  static const Color primaryLight = Color(0xFFEFF6FF);  // Soft Ice Blue tint
  static const Color primarySubtle = Color(0xFFF0F7FF); // Clean light blue wash

  // Neutral Backgrounds & Glass
  static const Color background = Color(0xFFF8FAFC);    // Ultra clean slate background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color cardBg = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);   // High-contrast slate 900
  static const Color textSecondary = Color(0xFF475569); // Slate 600
  static const Color textTertiary = Color(0xFF64748B);  // Slate 500
  static const Color textMuted = Color(0xFF94A3B8);     // Slate 400

  // Status & Accents
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFFFBEB);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEFF6FF);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderSubtle = Color(0xFFE8EEF5);

  // Kuwait Specific Badges
  static const Color kuwaitGold = Color(0xFFD97706);
  static const Color gccBlue = Color(0xFF2563EB);
  static const Color partTimePurple = Color(0xFF7C3AED);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0xFF1D4ED8), // Royal Blue
      Color(0xFF2563EB), // Vibrant Blue
      Color(0xFFDBEAFE), // Soft Mist Blue
      Color(0xFFF8FAFC), // Smooth Transition to Canvas
    ],
    stops: [0.0, 0.40, 0.82, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGlowGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Modern Soft Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: const Color(0xFF0F172A).withOpacity(0.04),
      blurRadius: 14,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0xFF1D4ED8).withOpacity(0.02),
      blurRadius: 6,
      offset: const Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: const Color(0xFF0F172A).withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0xFF1D4ED8).withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: const Color(0xFF1D4ED8).withOpacity(0.32),
      blurRadius: 16,
      offset: const Offset(0, 6),
      spreadRadius: 0,
    ),
  ];
}

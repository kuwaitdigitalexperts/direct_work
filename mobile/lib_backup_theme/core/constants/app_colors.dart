import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Direct Work Royal Blue Palette)
  static const Color primary = Color(0xFF1D4ED8);       // Modern Royal Blue
  static const Color primaryDark = Color(0xFF1E3A8A);   // Deep Navy Sapphire
  static const Color primaryDeep = Color(0xFF172554);   // Rich Midnight Blue
  static const Color primaryLight = Color(0xFFEFF6FF);  // Soft Ice Blue tint
  static const Color primarySubtle = Color(0xFFF0F7FF); // Clean light blue wash

  // Neutral Backgrounds
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  // Status & Accents
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);

  // Kuwait Specific Badges
  static const Color kuwaitGold = Color(0xFFD97706);
  static const Color gccBlue = Color(0xFF2563EB);
  static const Color partTimePurple = Color(0xFF7C3AED);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF1D4ED8), Color(0xFF1E3A8A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

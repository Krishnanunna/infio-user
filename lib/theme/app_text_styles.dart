import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Type scale from design_reference/hyperlocal_glass_modern/DESIGN.md.
/// Font family is Inter throughout.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _inter({
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
    double? letterSpacing,
    Color color = AppColors.onSurface,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height / fontSize,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle displayLg = _inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40,
    letterSpacing: -0.02 * 32,
  );

  static TextStyle headlineLg = _inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32,
  );

  static TextStyle headlineLgMobile = _inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 28,
  );

  static TextStyle titleMd = _inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24,
  );

  static TextStyle bodyLg = _inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24,
  );

  static TextStyle bodySm = _inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20,
  );

  static TextStyle labelMd = _inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16,
    letterSpacing: 0.05 * 12,
  );
}

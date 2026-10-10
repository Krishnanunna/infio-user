import 'package:flutter/material.dart';

/// Color tokens from the Stitch design system
/// (design_reference/hyperlocal_glass_modern/DESIGN.md).
///
/// Named after Material Design 3 roles so they map directly onto
/// [ColorScheme] in app_theme.dart. Light mode only for now — the
/// Stitch export didn't provide explicit dark-mode hex values, only
/// written guidance ("deep navy-charcoal background").
class AppColors {
  AppColors._();

  static const surface = Color(0xFFF9F9FF);
  static const surfaceDim = Color(0xFFD3DAEA);
  static const surfaceBright = Color(0xFFF9F9FF);
  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF0F3FF);
  static const surfaceContainer = Color(0xFFE7EEFE);
  static const surfaceContainerHigh = Color(0xFFE2E8F8);
  static const surfaceContainerHighest = Color(0xFFDCE2F3);
  static const surfaceVariant = Color(0xFFDCE2F3);

  static const onSurface = Color(0xFF151C27);
  static const onSurfaceVariant = Color(0xFF4D4354);
  static const inverseSurface = Color(0xFF2A313D);
  static const inverseOnSurface = Color(0xFFEBF1FF);

  static const outline = Color(0xFF7F7386);
  static const outlineVariant = Color(0xFFD0C1D7);

  static const surfaceTint = Color(0xFF8B1BD9);
  static const primary = Color(0xFF8A19D8);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFA540F3);
  static const onPrimaryContainer = Color(0xFFFFFFFF);
  static const inversePrimary = Color(0xFFE0B6FF);
  static const primaryFixed = Color(0xFFF2DAFF);
  static const primaryFixedDim = Color(0xFFE0B6FF);
  static const onPrimaryFixed = Color(0xFF2E004E);
  static const onPrimaryFixedVariant = Color(0xFF6C00AE);

  static const secondary = Color(0xFF5F5E5E);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFE5E2E1);
  static const onSecondaryContainer = Color(0xFF656464);
  static const secondaryFixed = Color(0xFFE5E2E1);
  static const secondaryFixedDim = Color(0xFFC8C6C5);
  static const onSecondaryFixed = Color(0xFF1C1B1B);
  static const onSecondaryFixedVariant = Color(0xFF474646);

  static const tertiary = Color(0xFF835400);
  static const onTertiary = Color(0xFFFFFFFF);
  static const tertiaryContainer = Color(0xFFA46A00);
  static const onTertiaryContainer = Color(0xFFFFFFFF);
  static const tertiaryFixed = Color(0xFFFFDDB5);
  static const tertiaryFixedDim = Color(0xFFFFB958);
  static const onTertiaryFixed = Color(0xFF2A1800);
  static const onTertiaryFixedVariant = Color(0xFF643F00);

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);

  static const background = Color(0xFFF9F9FF);
  static const onBackground = Color(0xFF151C27);

  /// User-facing (consumer) app accent — green, for discovery/search/action.
  static const userAccentGreen = Color(0xFF22C55E);

  /// Business/Partner-facing app accent — blue, for analytics/management.
  static const businessAccentBlue = Color(0xFF2563EB);

  /// Glass panel fill (light mode): white at 70-80% opacity.
  static Color glassFill({double opacity = 0.7}) =>
      Colors.white.withValues(alpha: opacity);

  /// Glass border stroke: white at 20-40% opacity.
  static Color glassStroke({double opacity = 0.2}) =>
      Colors.white.withValues(alpha: opacity);
}

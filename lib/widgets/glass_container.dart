import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// The "glassmorphism" panel used throughout the Stitch designs: a blurred,
/// translucent white surface with a subtle white border
/// (design_reference/hyperlocal_glass_modern/DESIGN.md — "The Glass Effect").
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = AppRadius.lg,
    this.opacity = 0.7,
    this.blurSigma = 12,
    this.color,
    this.border,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double opacity;
  final double blurSigma;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? AppColors.glassFill(opacity: opacity),
              borderRadius: radius,
              border: border ??
                  Border.all(color: AppColors.glassStroke(opacity: 0.4)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

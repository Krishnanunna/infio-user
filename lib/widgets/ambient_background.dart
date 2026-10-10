import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The soft, blurred decorative color blobs used behind auth/transactional
/// screens (design_reference/user_login_minimalist_redesign,
/// user_otp_verification_minimalist_redesign, etc. — "Ambient Decorative
/// Elements" / `.bg-mesh`), plus the flat mesh-gradient background color.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -80,
            child: _blob(220, AppColors.primary.withValues(alpha: 0.12)),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: _blob(280, AppColors.primaryContainer.withValues(alpha: 0.10)),
          ),
          child,
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

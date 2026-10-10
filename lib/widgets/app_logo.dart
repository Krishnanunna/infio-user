import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';

/// The "InFio" logo (design_reference/user_app_minimal_splash_screen,
/// user_login_minimalist_redesign, user_otp_verification_minimalist_redesign)
/// — loads the real photo from the Stitch export, falling back to a local
/// gradient mark if the network image is ever unavailable so branding never
/// disappears outright.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 96, this.showWordmark = true});

  final double size;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final mark = Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        color: Colors.white.withValues(alpha: 0.7),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.18),
        child: Image.network(
          kInfioLogoUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : _fallbackMark(size),
          errorBuilder: (context, error, stack) => _fallbackMark(size),
        ),
      ),
    );

    if (!showWordmark) return mark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(height: 12),
        Text(
          'InFio',
          style: TextStyle(
            fontSize: size * 0.22,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _fallbackMark(double size) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryContainer, AppColors.primary],
        ),
      ),
      child: Icon(Icons.location_on, color: Colors.white, size: size * 0.5),
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Small shared pieces reused across many screens: rating chips, initial
/// avatars standing in for the Stitch designs' remote photos, a gradient
/// placeholder for banner/portfolio imagery, and a list section header.

/// A star + rating value, as seen on business/quote cards throughout the
/// designs (e.g. design_reference/user_search_results_ac_repair).
class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating, this.compact = false});

  final double rating;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: compact ? 14 : 16, color: AppColors.tertiary),
        const SizedBox(width: 2),
        Text(
          rating.toStringAsFixed(1),
          style: (compact ? AppTextStyles.labelMd : AppTextStyles.bodySm)
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

/// Circular initial-letter avatar used in place of the Stitch designs'
/// network provider/user photos, so the app has no external image dependency.
class InitialAvatar extends StatelessWidget {
  const InitialAvatar({
    super.key,
    required this.text,
    this.size = 48,
    this.color = AppColors.primaryContainer,
  });

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: color.withValues(alpha: 0.15),
      child: Text(
        text.isNotEmpty ? text[0].toUpperCase() : '?',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}

/// Rounded gradient block with a centered icon — a stand-in for the Stitch
/// designs' photographic hero/portfolio imagery.
class GradientPlaceholder extends StatelessWidget {
  const GradientPlaceholder({
    super.key,
    required this.icon,
    this.colors = const [AppColors.primaryContainer, AppColors.primary],
    this.borderRadius = AppRadius.md,
    this.iconSize = 32,
  });

  final IconData icon;
  final List<Color> colors;
  final double borderRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: iconSize),
      ),
    );
  }
}

/// "Title" + "See All" row used above horizontal rails and list sections.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing, this.onTrailingTap});

  final String title;
  final String? trailing;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: AppTextStyles.titleMd),
        if (trailing != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Text(
              trailing!,
              style: AppTextStyles.labelMd.copyWith(color: AppColors.primaryContainer),
            ),
          ),
      ],
    );
  }
}

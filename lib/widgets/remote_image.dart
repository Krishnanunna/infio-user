import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'common.dart';

/// Loads a photo from the Stitch design export's image URLs, with a graceful
/// fallback to the existing icon-based placeholder if the URL is missing or
/// fails to load — the Stitch HTML itself does this in places (e.g. one
/// search-results card layers an "hvac" icon behind its `<img>`), so this
/// mirrors the original design's own fallback pattern rather than inventing
/// a new one.
class RemoteImage extends StatelessWidget {
  const RemoteImage({
    super.key,
    required this.url,
    required this.fallbackIcon,
    this.fallbackColors = const [AppColors.primaryContainer, AppColors.primary],
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
  });

  final String? url;
  final IconData fallbackIcon;
  final List<Color> fallbackColors;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    if (url == null || url!.isEmpty) {
      return ClipRRect(
        borderRadius: radius,
        child: GradientPlaceholder(
          icon: fallbackIcon,
          colors: fallbackColors,
          borderRadius: borderRadius,
        ),
      );
    }
    return ClipRRect(
      borderRadius: radius,
      child: Image.network(
        url!,
        fit: fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return GradientPlaceholder(
            icon: fallbackIcon,
            colors: fallbackColors,
            borderRadius: borderRadius,
          );
        },
        errorBuilder: (context, error, stack) => GradientPlaceholder(
          icon: fallbackIcon,
          colors: fallbackColors,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Circular provider/user photo, falling back to [InitialAvatar] — matching
/// the Stitch designs, where some provider cards use a photo and others
/// (e.g. "FixIt Now Services" on the available-quotes screen) use a plain
/// initial-letter avatar even in the original export.
class RemoteAvatar extends StatelessWidget {
  const RemoteAvatar({
    super.key,
    required this.url,
    required this.fallbackText,
    this.size = 48,
    this.color = AppColors.primaryContainer,
  });

  final String? url;
  final String fallbackText;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return InitialAvatar(text: fallbackText, size: size, color: color);
    }
    return ClipOval(
      child: Image.network(
        url!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : InitialAvatar(text: fallbackText, size: size, color: color),
        errorBuilder: (context, error, stack) =>
            InitialAvatar(text: fallbackText, size: size, color: color),
      ),
    );
  }
}

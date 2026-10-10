import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// The frosted, blurred top app bar used on nearly every screen
/// (`bg-white/70 backdrop-blur-xl border-b border-white/20`), with a back
/// button by default and optional custom leading/title/actions.
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.actions = const [],
    this.leadingIcon,
    this.onLeadingTap,
    this.centerTitle = false,
  });

  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final List<Widget> actions;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final leading = leadingIcon != null || showBackButton
        ? IconButton(
            icon: Icon(leadingIcon ?? Icons.arrow_back_outlined, color: AppColors.onSurface),
            onPressed: onLeadingTap ?? () => Navigator.of(context).maybePop(),
          )
        : const SizedBox(width: 48);

    final titleContent = titleWidget ??
        Text(
          title ?? '',
          style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary),
        );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.stackGapSm),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            border: const Border(bottom: BorderSide(color: Colors.white24)),
          ),
          child: Row(
            children: [
              leading,
              Expanded(
                child: centerTitle
                    ? Center(child: titleContent)
                    : Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: titleContent,
                      ),
              ),
              ...actions,
              if (actions.isEmpty) const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}

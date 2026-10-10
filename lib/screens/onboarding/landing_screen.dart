import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/gradient_button.dart';

/// design_reference/user_app_immersive_landing_page
/// ("Everything you need, in 60 seconds.").
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.containerMargin),
            child: Column(
              children: [
                const Spacer(),
                const AppLogo(size: 120, showWordmark: false),
                const SizedBox(height: AppSpacing.stackGapLg),
                Text(
                  'Everything you need, in 60 seconds.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineLg,
                ),
                const SizedBox(height: AppSpacing.stackGapSm),
                Text(
                  'Find, discover, and connect with verified professionals '
                  'for any task, anywhere.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLg
                      .copyWith(color: AppColors.onSurfaceVariant),
                ),
                const Spacer(),
                GradientButton(
                  label: 'Get Started',
                  onPressed: () => context.go('/login'),
                ),
                const SizedBox(height: AppSpacing.stackGapLg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

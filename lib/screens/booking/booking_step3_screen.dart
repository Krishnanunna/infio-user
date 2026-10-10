import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/gradient_button.dart';
import 'booking_progress.dart';
import 'booking_step2_screen.dart';

/// Everything gathered across steps 1 & 2, ready to submit.
class BookingDetails {
  const BookingDetails({
    required this.selection,
    required this.fullName,
    required this.area,
    required this.budgetRange,
    required this.description,
    required this.photoCount,
  });

  final BookingSelection selection;
  final String fullName;
  final String area;
  final String budgetRange;
  final String description;
  final int photoCount;
}

/// Step 3 of the get-a-quote flow: design_reference/user_booking_step_3_review.
class BookingStep3Screen extends StatelessWidget {
  const BookingStep3Screen({super.key, required this.details});

  final BookingDetails details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlassAppBar(title: 'InFio'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.containerMargin,
          AppSpacing.stackGapMd,
          AppSpacing.containerMargin,
          140,
        ),
        children: [
          const BookingProgress(currentStep: 2, labels: ['Details', 'Media', 'Review']),
          const SizedBox(height: AppSpacing.stackGapLg),
          Text('Review & Submit', style: AppTextStyles.headlineLgMobile),
          const SizedBox(height: AppSpacing.stackGapMd),
          GlassContainer(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            child: Column(
              children: [
                _ReviewRow(
                  icon: details.selection.category.icon,
                  label: 'Service',
                  value: '${details.selection.category.name} - ${details.selection.subCategory}',
                  emphasize: true,
                ),
                const Divider(color: AppColors.outlineVariant, height: AppSpacing.stackGapLg),
                _ReviewRow(icon: Icons.location_on_outlined, label: 'Location', value: details.area),
                const Divider(color: AppColors.outlineVariant, height: AppSpacing.stackGapLg),
                const _ReviewRow(
                  icon: Icons.calendar_month_outlined,
                  label: 'Schedule',
                  value: 'Tomorrow, 10:00 AM',
                ),
                const Divider(color: AppColors.outlineVariant, height: AppSpacing.stackGapLg),
                _ReviewRow(
                  icon: Icons.payments_outlined,
                  label: 'Estimated Budget',
                  value: details.budgetRange,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapLg),
          Text('Problem Description', style: AppTextStyles.titleMd),
          const SizedBox(height: AppSpacing.stackGapSm),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
            ),
            child: Text(
              '"${details.description}"',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ),
          if (details.photoCount > 0) ...[
            const SizedBox(height: AppSpacing.stackGapLg),
            Text('Attached Photos', style: AppTextStyles.titleMd),
            const SizedBox(height: AppSpacing.stackGapSm),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: details.photoCount,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.gridGutter),
                itemBuilder: (context, i) => Container(
                  width: 96,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.image_outlined, color: AppColors.outline),
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.stackGapLg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outlined, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      children: const [
                        TextSpan(text: 'Your request will be sent to '),
                        TextSpan(
                          text: '5 verified partners',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' near you. You will receive quotes within '),
                        TextSpan(
                          text: '15 minutes',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.containerMargin,
            AppSpacing.stackGapSm,
            AppSpacing.containerMargin,
            AppSpacing.stackGapSm,
          ),
          child: GradientButton(
            label: 'Submit Request',
            icon: Icons.send_outlined,
            colors: const [Color(0xFFB55AFF), AppColors.primary],
            // Land on the quotes hub (Orders tab) rather than jumping straight
            // into one request's detail screen — that hub is "the quotes
            // screen" a user expects after submitting, and it keeps the
            // bottom nav available; from there "View Quotes" on the new
            // request opens this same available-quotes detail screen.
            onPressed: () => context.go('/orders'),
          ),
        ),
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.icon,
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMd.copyWith(color: AppColors.secondary)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: emphasize
                    ? AppTextStyles.titleMd
                    : AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

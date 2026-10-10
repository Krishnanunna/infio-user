import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// The 3-step "Details / Problem / Review" progress indicator repeated across
/// the get-a-quote flow (design_reference/user_booking_step_1_selection,
/// user_booking_step_2_form, user_booking_step_3_review).
class BookingProgress extends StatelessWidget {
  const BookingProgress({
    super.key,
    required this.currentStep,
    this.labels = const ['Details', 'Problem', 'Review'],
  });

  /// 0-indexed step currently active.
  final int currentStep;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          _Step(index: i, label: labels[i], state: _stateFor(i)),
          if (i < labels.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 20),
                color: i < currentStep ? AppColors.primary : AppColors.surfaceVariant,
              ),
            ),
        ],
      ],
    );
  }

  _StepState _stateFor(int i) {
    if (i < currentStep) return _StepState.done;
    if (i == currentStep) return _StepState.active;
    return _StepState.pending;
  }
}

enum _StepState { done, active, pending }

class _Step extends StatelessWidget {
  const _Step({required this.index, required this.label, required this.state});

  final int index;
  final String label;
  final _StepState state;

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    final Border? border;
    switch (state) {
      case _StepState.done:
        bg = AppColors.primary;
        fg = Colors.white;
        border = null;
        break;
      case _StepState.active:
        bg = AppColors.primaryContainer;
        fg = AppColors.onPrimaryContainer;
        border = null;
        break;
      case _StepState.pending:
        bg = AppColors.surfaceVariant;
        fg = AppColors.onSurfaceVariant;
        border = Border.all(color: AppColors.outlineVariant);
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle, border: border),
          child: Center(
            child: state == _StepState.done
                ? Icon(Icons.check_outlined, color: fg, size: 18)
                : Text('${index + 1}',
                    style: AppTextStyles.titleMd.copyWith(color: fg)),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            color: state == _StepState.pending ? AppColors.onSurfaceVariant : AppColors.primary,
          ),
        ),
      ],
    );
  }
}

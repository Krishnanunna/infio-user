import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/service_category.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/gradient_button.dart';
import 'booking_progress.dart';
import 'booking_step3_screen.dart';

/// Category + sub-category picked in step 1, carried into step 2.
class BookingSelection {
  const BookingSelection({required this.category, required this.subCategory});

  final ServiceCategory category;
  final String subCategory;
}

/// Step 2 of the get-a-quote flow: design_reference/user_booking_step_2_form.
class BookingStep2Screen extends StatefulWidget {
  const BookingStep2Screen({super.key, required this.selection});

  final BookingSelection selection;

  @override
  State<BookingStep2Screen> createState() => _BookingStep2ScreenState();
}

class _BookingStep2ScreenState extends State<BookingStep2Screen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _areaController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _budgetRange = '\$100 - \$300';
  int _photoCount = 1;

  static const _budgetOptions = ['Under \$100', '\$100 - \$300', '\$300 - \$500', '\$500+'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _continue() {
    context.push(
      '/booking/step3',
      extra: BookingDetails(
        selection: widget.selection,
        fullName: _nameController.text.trim().isEmpty ? 'Guest User' : _nameController.text.trim(),
        area: _areaController.text.trim().isEmpty ? 'Kukatpally, 500072' : _areaController.text.trim(),
        budgetRange: _budgetRange,
        description: _descriptionController.text.trim().isEmpty
            ? 'The AC is not cooling properly. It turns on, but only blows warm air.'
            : _descriptionController.text.trim(),
        photoCount: _photoCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_outlined),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Get Quotes'),
        centerTitle: true,
        backgroundColor: Colors.white.withValues(alpha: 0.8),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.containerMargin,
              vertical: AppSpacing.stackGapMd,
            ),
            child: const BookingProgress(currentStep: 1),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.containerMargin,
                0,
                AppSpacing.containerMargin,
                120,
              ),
              children: [
                _FormSection(
                  icon: Icons.person_outlined,
                  title: 'Contact Info',
                  children: [
                    _LabeledField(label: 'Full Name', controller: _nameController, hint: 'John Doe'),
                    const SizedBox(height: AppSpacing.stackGapMd),
                    _LabeledField(
                      label: 'Mobile Number',
                      controller: _phoneController,
                      hint: '(555) 000-0000',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.stackGapMd),
                _FormSection(
                  icon: widget.selection.category.icon,
                  title: 'Service Details',
                  children: [
                    _LabeledField(label: 'Area/ZIP', controller: _areaController, hint: 'e.g. 10001'),
                    const SizedBox(height: AppSpacing.stackGapMd),
                    Text('Estimated Budget Range',
                        style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final option in _budgetOptions)
                          _BudgetChip(
                            label: option,
                            selected: option == _budgetRange,
                            onTap: () => setState(() => _budgetRange = option),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.stackGapMd),
                    Text('Describe the problem',
                        style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Please provide specific details to help partners '
                            'give an accurate quote...',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.stackGapMd),
                _FormSection(
                  icon: Icons.photo_camera_outlined,
                  title: 'Photos',
                  trailing: 'Max 3 photos',
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          if (i > 0) const SizedBox(width: AppSpacing.gridGutter),
                          Expanded(child: _PhotoSlot(index: i, filledCount: _photoCount, onAdd: () {
                            setState(() => _photoCount = (_photoCount + 1).clamp(0, 3));
                          })),
                        ],
                      ],
                    ),
                  ],
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
            label: 'Continue to Review',
            icon: Icons.arrow_forward_outlined,
            onPressed: _continue,
          ),
        ),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection({
    required this.icon,
    required this.title,
    required this.children,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.stackGapMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(title, style: AppTextStyles.titleMd),
                ],
              ),
              if (trailing != null)
                Text(trailing!,
                    style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapMd),
          ...children,
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hint,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }
}

class _BudgetChip extends StatelessWidget {
  const _BudgetChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: selected ? AppColors.primary : Colors.transparent),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySm.copyWith(
            color: selected ? AppColors.primary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  const _PhotoSlot({required this.index, required this.filledCount, required this.onAdd});

  final int index;
  final int filledCount;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return GestureDetector(
        onTap: onAdd,
        child: AspectRatio(
          aspectRatio: 1,
          child: DottedBorderBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_photo_alternate_outlined, color: AppColors.primary, size: 28),
                const SizedBox(height: 2),
                Text('Add', style: AppTextStyles.labelMd),
              ],
            ),
          ),
        ),
      );
    }

    final filled = index < filledCount;
    return AspectRatio(
      aspectRatio: 1,
      child: filled
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: const Icon(Icons.image_outlined, color: AppColors.outline),
            )
          : Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.solid),
              ),
              child: Icon(Icons.image_outlined, color: AppColors.outlineVariant.withValues(alpha: 0.5)),
            ),
    );
  }
}

/// Simple dashed-border container (Flutter has no built-in dashed border).
class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: AppColors.primary, radius: AppRadius.md),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}

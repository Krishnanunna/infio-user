import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/service_category.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import 'booking_progress.dart';
import 'booking_step2_screen.dart';

/// Step 1 of the get-a-quote flow: design_reference/user_booking_step_1_selection.
class BookingStep1Screen extends StatefulWidget {
  const BookingStep1Screen({super.key});

  @override
  State<BookingStep1Screen> createState() => _BookingStep1ScreenState();
}

class _BookingStep1ScreenState extends State<BookingStep1Screen> {
  ServiceCategory? _category;
  String? _subCategory;
  final _scrollController = ScrollController();

  bool get _canContinue => _category != null && _subCategory != null;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectCategory(ServiceCategory category) {
    setState(() {
      _category = category;
      _subCategory = null;
    });
    // The sub-category chips revealed below often sit past the fold, so
    // without this the Continue button looks stuck disabled for no visible
    // reason. The chips are always the last thing in the list (right above
    // the fixed Continue bar), so — unlike scrolling a specific widget into
    // view, which races the layout pass that first measures it — jumping to
    // the scroll extent is simple and always lands in the right place.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  void _continue() {
    if (!_canContinue) return;
    context.push(
      '/booking/step2',
      extra: BookingSelection(category: _category!, subCategory: _subCategory!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlassAppBar(title: 'Select Service'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.containerMargin,
                vertical: AppSpacing.stackGapLg,
              ),
              children: [
                const BookingProgress(currentStep: 0),
                const SizedBox(height: AppSpacing.stackGapLg),
                Text('Select Category', style: AppTextStyles.titleMd),
                const SizedBox(height: AppSpacing.stackGapMd),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: MockData.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.gridGutter,
                    crossAxisSpacing: AppSpacing.gridGutter,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, i) {
                    final category = MockData.categories[i];
                    final selected = category.id == _category?.id;
                    return GestureDetector(
                      onTap: () => _selectCategory(category),
                      child: GlassContainer(
                        borderRadius: AppRadius.lg,
                        color: selected
                            ? AppColors.primary.withValues(alpha: 0.05)
                            : null,
                        border: selected
                            ? Border.all(color: AppColors.primary)
                            : null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(
                                color: AppColors.surfaceContainerHigh,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(category.icon,
                                  color: AppColors.primary, size: 30),
                            ),
                            const SizedBox(height: AppSpacing.stackGapSm),
                            Text(category.name,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.titleMd),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (_category != null) ...[
                  const SizedBox(height: AppSpacing.stackGapLg),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.stackGapSm),
                    decoration: BoxDecoration(
                      color: _subCategory == null
                          ? AppColors.primary.withValues(alpha: 0.04)
                          : null,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select ${_category!.name} Service',
                            style: AppTextStyles.titleMd),
                        const SizedBox(height: 4),
                        Text('Pick one to continue',
                            style: AppTextStyles.bodySm
                                .copyWith(color: AppColors.onSurfaceVariant)),
                        const SizedBox(height: AppSpacing.stackGapMd),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final sub in _category!.subCategories)
                              _SubCategoryChip(
                                label: sub,
                                selected: sub == _subCategory,
                                onTap: () => setState(() => _subCategory = sub),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.containerMargin,
                AppSpacing.stackGapSm,
                AppSpacing.containerMargin,
                AppSpacing.stackGapSm,
              ),
              child: ElevatedButton(
                onPressed: _canContinue ? _continue : null,
                child: const Text('Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubCategoryChip extends StatelessWidget {
  const _SubCategoryChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: selected ? AppColors.primary : AppColors.outlineVariant),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            color: selected ? Colors.white : AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}

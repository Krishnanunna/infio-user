import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/quote.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/available_quotes_refined_view ("Get Quotes & Status").
class AvailableQuotesScreen extends StatelessWidget {
  const AvailableQuotesScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final request = MockData.requestById(requestId);

    return Scaffold(
      appBar: GlassAppBar(
        titleWidget: Text('InFio Search',
            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
        actions: [
          if (request.quotes.length > 1)
            TextButton(
              onPressed: () => context.push('/quotes/$requestId/compare'),
              child: const Text('Compare'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/booking/step1'),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.containerMargin,
          AppSpacing.stackGapLg,
          AppSpacing.containerMargin,
          AppSpacing.stackGapLg,
        ),
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(request.icon, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.title, style: AppTextStyles.titleMd),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.onSurfaceVariant),
                          const SizedBox(width: 2),
                          Text(request.locationLabel,
                              style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(
                        request.quotes.isEmpty ? 'Awaiting' : '${request.quotes.length} Quotes',
                        style: AppTextStyles.labelMd.copyWith(
                            color: AppColors.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Respond by 6:00 PM',
                        style: AppTextStyles.labelMd.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapLg),
          Text('Available Quotes', style: AppTextStyles.titleMd),
          const SizedBox(height: AppSpacing.stackGapMd),
          if (request.quotes.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.stackGapLg),
              child: Column(
                children: [
                  const Icon(Icons.hourglass_top_outlined, size: 40, color: AppColors.outline),
                  const SizedBox(height: AppSpacing.stackGapSm),
                  Text('Waiting for partners to respond...',
                      style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            )
          else
            for (final quote in request.quotes) ...[
              _QuoteCard(quote: quote),
              const SizedBox(height: AppSpacing.stackGapMd),
            ],
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.stackGapMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (quote.badge != null)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_outlined, size: 14, color: AppColors.tertiary),
                    const SizedBox(width: 4),
                    Text(quote.badge!,
                        style: AppTextStyles.labelMd.copyWith(color: AppColors.tertiary)),
                  ],
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RemoteAvatar(url: quote.avatarUrl, fallbackText: quote.providerName),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(quote.providerName, style: AppTextStyles.titleMd),
                    Row(
                      children: [
                        RatingBadge(rating: quote.rating),
                        Text(' (${quote.reviewCount} reviews)',
                            style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${quote.price}',
                      style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                  Text('Est. Total',
                      style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final h in quote.highlights)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outlined, size: 16, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(h,
                              style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outlined, size: 20),
                  label: const Text('Accept'),
                ),
              ),
              const SizedBox(width: 8),
              _SquareIconButton(icon: Icons.call_outlined, onTap: () {}),
              const SizedBox(width: 8),
              _SquareIconButton(icon: Icons.close_outlined, onTap: () {}, danger: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.icon, required this.onTap, this.danger = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: danger ? AppColors.error : AppColors.primary),
      ),
    );
  }
}

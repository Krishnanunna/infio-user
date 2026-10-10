import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/quote.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/user_quote_comparison_refined ("Compare Quotes").
class QuoteComparisonScreen extends StatelessWidget {
  const QuoteComparisonScreen({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final request = MockData.requestById(requestId);

    return Scaffold(
      appBar: GlassAppBar(
        titleWidget: Text('InFio',
            style: AppTextStyles.headlineLg.copyWith(color: AppColors.primary)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.location_on, color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.containerMargin,
          AppSpacing.stackGapLg,
          AppSpacing.containerMargin,
          AppSpacing.stackGapLg,
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(request.icon, size: 16, color: AppColors.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(request.title,
                    style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Text('Compare Quotes', style: AppTextStyles.displayLg),
          const SizedBox(height: 4),
          Text('${request.quotes.length} partners have responded to your request.',
              style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.stackGapLg),
          for (final quote in request.quotes) ...[
            _ComparisonCard(quote: quote),
            const SizedBox(height: AppSpacing.stackGapMd),
          ],
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final featured = quote.badge != null;
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      border: featured ? null : Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RemoteAvatar(url: quote.avatarUrl, fallbackText: quote.providerName, size: 48),
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
                  if (quote.badge != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryFixed,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Text(quote.badge!.toUpperCase(),
                          style: AppTextStyles.labelMd
                              .copyWith(fontSize: 9, color: AppColors.onTertiaryFixed)),
                    ),
                  Text('₹${quote.price}',
                      style: AppTextStyles.displayLg.copyWith(color: AppColors.primary, fontSize: 26)),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      quote.isFixedPrice ? 'FIXED' : 'ESTIMATED',
                      style: AppTextStyles.labelMd
                          .copyWith(fontSize: 9, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text('"${quote.message}"',
                style: AppTextStyles.bodySm
                    .copyWith(color: AppColors.onSurface, fontStyle: FontStyle.italic)),
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Row(
            children: [
              Icon(Icons.schedule_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(quote.availability, style: AppTextStyles.labelMd),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close_outlined, size: 16),
                  label: const Text('Reject',
                      maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call_outlined, size: 16),
                  label: const Text('Call',
                      maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_outlined, size: 16),
                  label: const Text('Accept & Chat',
                      maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 44),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    textStyle: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

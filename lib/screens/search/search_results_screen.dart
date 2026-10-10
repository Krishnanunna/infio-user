import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/business.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/user_search_results_ac_repair.
///
/// Reused both as the "Categories" bottom-nav tab (`embedded: true`, no
/// dedicated categories screen was exported by Stitch) and pushed as a
/// standalone search-results screen from Home's search bar / category taps.
class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key, this.embedded = false, this.query});

  final bool embedded;
  final String? query;

  @override
  Widget build(BuildContext context) {
    final effectiveQuery = query ?? (embedded ? 'Browse Services' : 'AC Repair');

    return Scaffold(
      appBar: GlassAppBar(
        showBackButton: !embedded,
        leadingIcon: embedded ? Icons.location_on_outlined : null,
        onLeadingTap: embedded ? () {} : null,
        titleWidget: Text('InFio Search',
            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.containerMargin,
          AppSpacing.stackGapMd,
          AppSpacing.containerMargin,
          AppSpacing.stackGapLg,
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_outlined, color: AppColors.outline),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(effectiveQuery, style: AppTextStyles.bodySm),
                ),
                const Icon(Icons.tune_outlined, color: AppColors.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapSm),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _FilterChip(label: 'Verified', icon: Icons.verified_outlined, selected: true),
                _FilterChip(label: 'Rating 4.0+'),
                _FilterChip(label: 'Price', icon: Icons.expand_more_outlined),
                _FilterChip(label: 'Distance', icon: Icons.expand_more_outlined),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapLg),
          for (final business in MockData.searchResults) ...[
            _SearchResultCard(business: business),
            const SizedBox(height: AppSpacing.stackGapMd),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.icon, this.selected = false});

  final String label;
  final IconData? icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GlassContainer(
        borderRadius: AppRadius.full,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        color: selected ? AppColors.primaryContainer.withValues(alpha: 0.1) : null,
        border: selected ? Border.all(color: AppColors.primaryContainer) : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: selected ? AppColors.primaryContainer : AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
            ],
            Text(label,
                style: AppTextStyles.labelMd.copyWith(
                    color: selected ? AppColors.primaryContainer : AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({required this.business});

  final Business business;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/business/${business.id}'),
      child: GlassContainer(
        padding: const EdgeInsets.all(AppSpacing.stackGapMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: RemoteImage(
                          url: business.photoUrl,
                          fallbackIcon: business.icon,
                          fallbackColors: [business.accentColor, business.accentColor.withValues(alpha: 0.6)],
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: RatingBadge(rating: business.rating, compact: true),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(business.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.titleMd),
                          ),
                          const Icon(Icons.bookmark_border_outlined,
                              size: 20, color: AppColors.outlineVariant),
                        ],
                      ),
                      Text(business.tagline,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          if (business.experienceYears != null)
                            _MetaTag(icon: Icons.work_history_outlined, label: '${business.experienceYears} Yrs Exp.'),
                          _MetaTag(icon: Icons.near_me_outlined, label: business.distanceLabel),
                          if (business.startingPrice != null)
                            _MetaTag(icon: Icons.payments_outlined, label: 'From ${business.startingPrice}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.stackGapSm),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.call_outlined, size: 16),
                    label: const Text('Call',
                        maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      textStyle: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat_outlined, size: 16, color: Color(0xFF25D366)),
                    label: const Text('WhatsApp',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Color(0xFF25D366), fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      side: const BorderSide(color: Color(0xFF25D366)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => context.push('/business/${business.id}'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('View'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  const _MetaTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 2),
        Text(label,
            style: AppTextStyles.labelMd.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/business_profile_page ("Elite AC Services").
class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key, required this.businessId});

  final String businessId;

  @override
  Widget build(BuildContext context) {
    final business = MockData.businessById(businessId);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 260,
                width: double.infinity,
                child: RemoteImage(
                  url: business.photoUrl,
                  fallbackIcon: business.icon,
                  fallbackColors: [business.accentColor, business.accentColor.withValues(alpha: 0.5)],
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceBright,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.containerMargin,
                        AppSpacing.stackGapLg,
                        AppSpacing.containerMargin,
                        100,
                      ),
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _Pill(
                              icon: Icons.verified_outlined,
                              label: 'Verified Partner',
                              background: const Color(0xFFE6F4EA),
                              foreground: const Color(0xFF137333),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.schedule_outlined,
                                    size: 14, color: AppColors.onSurfaceVariant),
                                const SizedBox(width: 4),
                                Text('Open now',
                                    style: AppTextStyles.labelMd
                                        .copyWith(color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(business.name, style: AppTextStyles.headlineLgMobile),
                        const SizedBox(height: AppSpacing.stackGapSm),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFBBC04)),
                            const SizedBox(width: 4),
                            Text(business.rating.toStringAsFixed(1), style: AppTextStyles.titleMd),
                            const SizedBox(width: 4),
                            Text('(${business.reviewCount} reviews)',
                                style: AppTextStyles.bodySm
                                    .copyWith(color: AppColors.onSurfaceVariant)),
                            const SizedBox(width: 12),
                            const Icon(Icons.location_on_outlined,
                                size: 18, color: AppColors.onSurfaceVariant),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(business.distanceLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodySm
                                      .copyWith(color: AppColors.onSurfaceVariant)),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.stackGapLg),
                        GlassContainer(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About Us', style: AppTextStyles.titleMd),
                              const SizedBox(height: 8),
                              Text(
                                business.about,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySm
                                    .copyWith(color: AppColors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 12),
                              const Divider(color: AppColors.outlineVariant),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Business Hours',
                                            style: AppTextStyles.labelMd
                                                .copyWith(color: AppColors.onSurfaceVariant)),
                                        Text(business.hours, style: AppTextStyles.bodySm),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_outlined, color: AppColors.primary),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.stackGapLg),
                        if (business.services.isNotEmpty) ...[
                          SectionHeader(title: 'Services', trailing: 'View all'),
                          const SizedBox(height: AppSpacing.stackGapMd),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: business.services.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.gridGutter,
                              crossAxisSpacing: AppSpacing.gridGutter,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, i) {
                              final service = business.services[i];
                              return GlassContainer(
                                borderRadius: AppRadius.md,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE6F4EA),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(service.icon, color: const Color(0xFF137333)),
                                    ),
                                    Text(service.name,
                                        style: AppTextStyles.titleMd.copyWith(fontSize: 14)),
                                    Text(service.priceLabel,
                                        style: AppTextStyles.labelMd
                                            .copyWith(color: AppColors.onSurfaceVariant)),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppSpacing.stackGapLg),
                        ],
                        Text('Recent Work', style: AppTextStyles.headlineLgMobile),
                        const SizedBox(height: AppSpacing.stackGapMd),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.4,
                          children: business.portfolioUrls.isNotEmpty
                              ? [
                                  for (final url in business.portfolioUrls)
                                    RemoteImage(
                                      url: url,
                                      fallbackIcon: Icons.photo_outlined,
                                      fallbackColors: [
                                        business.accentColor,
                                        business.accentColor.withValues(alpha: 0.5),
                                      ],
                                      borderRadius: AppRadius.sm,
                                    ),
                                ]
                              : [
                                  GradientPlaceholder(
                                    icon: Icons.photo_outlined,
                                    colors: [business.accentColor, business.accentColor.withValues(alpha: 0.5)],
                                  ),
                                  GradientPlaceholder(
                                    icon: Icons.photo_outlined,
                                    colors: [business.accentColor.withValues(alpha: 0.7), business.accentColor],
                                  ),
                                ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 44,
            left: AppSpacing.containerMargin,
            right: AppSpacing.containerMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleIconButton(
                  icon: Icons.arrow_back_outlined,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                Row(
                  children: [
                    _CircleIconButton(icon: Icons.favorite_border_outlined, onTap: () {}),
                    const SizedBox(width: 8),
                    _CircleIconButton(icon: Icons.share_outlined, onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GlassContainer(
              borderRadius: 0,
              padding: EdgeInsets.fromLTRB(
                16,
                12,
                16,
                12 + MediaQuery.of(context).padding.bottom,
              ),
              color: Colors.white.withValues(alpha: 0.9),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_outlined, size: 20),
                      label: const Text('Chat'),
                      style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => context.push('/booking/step1'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(0, 48)),
                      child: const Text('Book Service'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: foreground),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.labelMd.copyWith(color: foreground)),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Icon(icon, color: AppColors.onSurface, size: 20),
      ),
    );
  }
}

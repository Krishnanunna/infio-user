import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/business.dart';
import '../../models/service_category.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/common.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/user_home_integrated_quick_quote_section.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  int _bannerIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        showBackButton: false,
        leadingIcon: Icons.location_on_outlined,
        onLeadingTap: () {},
        titleWidget: Text('InFio Search',
            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.containerMargin,
          vertical: AppSpacing.stackGapMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchBar(onTap: () => context.push('/search')),
            const SizedBox(height: AppSpacing.stackGapLg),
            _HeroCarousel(
              controller: _pageController,
              currentIndex: _bannerIndex,
              onPageChanged: (i) => setState(() => _bannerIndex = i),
            ),
            const SizedBox(height: AppSpacing.stackGapLg),
            Text('Explore Services', style: AppTextStyles.titleMd),
            const SizedBox(height: AppSpacing.stackGapSm),
            _CategoryGrid(
              onSelect: (category) => context.push('/search?q=${category.name}'),
            ),
            const SizedBox(height: AppSpacing.stackGapLg),
            _FindBestMatchCard(onPressed: () => context.push('/booking/step1')),
            const SizedBox(height: AppSpacing.stackGapLg),
            SectionHeader(
              title: 'Near You',
              trailing: 'See All',
              onTrailingTap: () => context.push('/search'),
            ),
            const SizedBox(height: AppSpacing.stackGapSm),
            SizedBox(
              height: 176,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: MockData.nearYouBusinesses.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.stackGapMd),
                itemBuilder: (context, i) {
                  final business = MockData.nearYouBusinesses[i];
                  return _NearYouCard(
                    business: business,
                    onTap: () => context.push('/business/${business.id}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_outlined, color: AppColors.outline),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search for AC repair, Plumber...',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLg.copyWith(color: AppColors.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCarousel extends StatelessWidget {
  const _HeroCarousel({
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 21 / 9,
          child: PageView.builder(
            controller: controller,
            onPageChanged: onPageChanged,
            itemCount: homeBanners.length,
            itemBuilder: (context, i) {
              final banner = homeBanners[i];
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (banner.imageUrl != null)
                      Image.network(
                        banner.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) =>
                            progress == null ? child : Container(color: banner.gradientColors.last),
                        errorBuilder: (context, error, stack) =>
                            Container(color: banner.gradientColors.last),
                      ),
                    // Scrim so the overlaid text stays legible over the photo
                    // (mirrors the Stitch export's `bg-gradient-to-r ...
                    // via-X/40 to-transparent`).
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            banner.gradientColors.first.withValues(alpha: 0.92),
                            banner.gradientColors.last.withValues(alpha: 0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.stackGapMd),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 220),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(banner.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.displayLg.copyWith(
                                      color: Colors.white, fontSize: 20, height: 1.1)),
                              const SizedBox(height: 4),
                              Text(banner.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodySm
                                      .copyWith(color: Colors.white.withValues(alpha: 0.9))),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => context.push('/booking/step1'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryContainer,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(0, 32),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppRadius.full)),
                                ),
                                child: Text(banner.ctaLabel, style: AppTextStyles.titleMd),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(homeBanners.length, (i) {
              final active = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: active ? 1 : 0.5),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.onSelect});

  final ValueChanged<ServiceCategory> onSelect;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: MockData.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: AppSpacing.stackGapMd,
      ),
      itemBuilder: (context, i) {
        final category = MockData.categories[i];
        return GestureDetector(
          onTap: () => onSelect(category),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
                ),
                child: ClipOval(
                  child: category.imageUrl != null
                      ? Image.network(
                          category.imageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) => progress == null
                              ? child
                              : _CategoryIconFallback(icon: category.icon),
                          errorBuilder: (context, error, stack) =>
                              _CategoryIconFallback(icon: category.icon),
                        )
                      : _CategoryIconFallback(icon: category.icon),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryIconFallback extends StatelessWidget {
  const _CategoryIconFallback({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceContainerHigh,
      child: Icon(icon, color: AppColors.primary, size: 26),
    );
  }
}

class _FindBestMatchCard extends StatelessWidget {
  const _FindBestMatchCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      color: AppColors.surfaceContainerLow,
      padding: const EdgeInsets.all(AppSpacing.stackGapMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt_outlined, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Not sure who to pick?',
                        style: AppTextStyles.titleMd
                            .copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(
                      'Let our pros bid for your job. Get 3+ quotes in minutes.',
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapMd),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.auto_awesome_outlined, size: 20),
            label: const Text('Find Best Match'),
          ),
        ],
      ),
    );
  }
}

class _NearYouCard extends StatelessWidget {
  const _NearYouCard({required this.business, required this.onTap});

  final Business business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: AppRadius.md,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: RatingBadge(rating: business.rating, compact: true),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMd),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(business.distanceLabel,
                            style: AppTextStyles.bodySm
                                .copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

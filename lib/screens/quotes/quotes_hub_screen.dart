import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../models/quote_request.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/gradient_button.dart';

/// design_reference/user_quotes_requests_hub ("My Quotes & Requests").
class QuotesHubScreen extends StatefulWidget {
  const QuotesHubScreen({super.key});

  @override
  State<QuotesHubScreen> createState() => _QuotesHubScreenState();
}

class _QuotesHubScreenState extends State<QuotesHubScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        showBackButton: false,
        leadingIcon: Icons.menu_outlined,
        onLeadingTap: () {},
        titleWidget: Text('InFio',
            style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.containerMargin,
              AppSpacing.stackGapMd,
              AppSpacing.containerMargin,
              0,
            ),
            child: Text('My Quotes & Requests', style: AppTextStyles.headlineLgMobile),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.containerMargin,
              vertical: AppSpacing.stackGapMd,
            ),
            child: GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add_circle_outlined, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(height: AppSpacing.stackGapSm),
                  Text('Create New Quote', style: AppTextStyles.titleMd),
                  const SizedBox(height: 4),
                  Text(
                    'Start a new service request and get offers from local pros.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.stackGapMd),
                  GradientButton(
                    label: 'Get Started',
                    onPressed: () => context.push('/booking/step1'),
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.onSurfaceVariant,
            indicatorColor: AppColors.primary,
            labelStyle: AppTextStyles.labelMd,
            tabs: const [
              Tab(text: 'Active Quotes'),
              Tab(text: 'Past Requests'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ActiveQuotesList(requests: MockData.activeRequests),
                _PastRequestsList(requests: MockData.pastRequests),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveQuotesList extends StatelessWidget {
  const _ActiveQuotesList({required this.requests});

  final List<QuoteRequest> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.containerMargin,
        AppSpacing.stackGapMd,
        AppSpacing.containerMargin,
        AppSpacing.stackGapLg,
      ),
      itemCount: requests.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.stackGapMd),
      itemBuilder: (context, i) {
        final request = requests[i];
        final hasQuotes = request.quotes.isNotEmpty;
        return GlassContainer(
          padding: const EdgeInsets.all(AppSpacing.stackGapMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(request.icon, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(request.title, style: AppTextStyles.titleMd),
                        Text(request.requestedLabel,
                            style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: hasQuotes
                          ? AppColors.primaryContainer.withValues(alpha: 0.2)
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      hasQuotes ? '${request.quotes.length} Quotes' : 'Awaiting',
                      style: AppTextStyles.labelMd.copyWith(
                        color: hasQuotes ? AppColors.primary : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.stackGapSm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(hasQuotes ? 'Edit Request' : 'View Details'),
                    ),
                  ),
                  if (hasQuotes) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.push('/quotes/${request.id}/available'),
                        child: const Text('View Quotes'),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PastRequestsList extends StatelessWidget {
  const _PastRequestsList({required this.requests});

  final List<QuoteRequest> requests;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.containerMargin,
        AppSpacing.stackGapMd,
        AppSpacing.containerMargin,
        AppSpacing.stackGapLg,
      ),
      itemCount: requests.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.stackGapMd),
      itemBuilder: (context, i) {
        final request = requests[i];
        final canceled = request.status == QuoteRequestStatus.canceled;
        return Opacity(
          opacity: 0.85,
          child: GlassContainer(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(request.icon, color: AppColors.onSecondaryContainer, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request.title, style: AppTextStyles.titleMd),
                          Text(request.outcomeLabel ?? '',
                              style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: AppSpacing.stackGapLg, color: AppColors.outlineVariant),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      canceled
                          ? 'Reason: Found someone else'
                          : 'Hired: ${request.hiredProvider ?? '—'}',
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                    TextButton(
                      onPressed: () => context.push('/booking/step1'),
                      child: Text(canceled ? 'New Request' : 'Rebook'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

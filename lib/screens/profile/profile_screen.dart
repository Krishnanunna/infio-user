import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../data/mock_data.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/remote_image.dart';

/// design_reference/user_profile_referral.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        showBackButton: false,
        titleWidget: Text('Profile',
            style: AppTextStyles.displayLg.copyWith(color: AppColors.primary, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.onSurfaceVariant),
            onPressed: () {},
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
          GlassContainer(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            child: Row(
              children: [
                const RemoteAvatar(url: kUserAvatarUrl, fallbackText: 'Jane Doe', size: 80),
                const SizedBox(width: AppSpacing.stackGapMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jane Doe', style: AppTextStyles.titleMd),
                      Text('+91 98765 43210',
                          style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                      Text('jane.doe@example.com',
                          style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
                OutlinedButton(onPressed: () {}, child: const Text('Edit Profile')),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapLg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.stackGapMd),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.redeem_outlined, color: AppColors.tertiaryFixed),
                    const SizedBox(width: 8),
                    Text('Invite & Earn',
                        style: AppTextStyles.titleMd.copyWith(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: AppSpacing.stackGapSm),
                Text(
                  'Invite a neighbor, earn ₹100 service wallet cash!',
                  style: AppTextStyles.bodyLg
                      .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.stackGapSm),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('YOUR CODE',
                          style: AppTextStyles.labelMd
                              .copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      Text('JANE100',
                          style: AppTextStyles.headlineLgMobile
                              .copyWith(color: Colors.white, letterSpacing: 1.5)),
                      const SizedBox(height: AppSpacing.stackGapSm),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined, size: 18),
                          label: const Text('Share via WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            minimumSize: const Size(0, 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.stackGapLg),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: AppSpacing.gridGutter,
            crossAxisSpacing: AppSpacing.gridGutter,
            childAspectRatio: 1.3,
            children: [
              _MenuTile(icon: Icons.favorite_outlined, label: 'Saved Businesses'),
              _MenuTile(icon: Icons.star_rate_outlined, label: 'Review History'),
              _MenuTile(icon: Icons.language_outlined, label: 'Language', subtitle: 'English (US)'),
              _MenuTile(icon: Icons.help_outlined, label: 'Help & Support', subtitle: 'FAQs, Contact us'),
            ],
          ),
          const SizedBox(height: AppSpacing.stackGapMd),
          GlassContainer(
            borderRadius: AppRadius.md,
            padding: const EdgeInsets.all(AppSpacing.stackGapSm),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
            child: InkWell(
              onTap: () => context.go('/login'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_outlined, color: AppColors.error),
                  const SizedBox(width: 8),
                  Text('Log Out',
                      style: AppTextStyles.titleMd.copyWith(color: AppColors.error)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.label, this.subtitle});

  final IconData icon;
  final String label;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.stackGapMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: AppTextStyles.titleMd.copyWith(fontSize: 14)),
          if (subtitle != null)
            Text(subtitle!,
                style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant, fontSize: 11)),
        ],
      ),
    );
  }
}

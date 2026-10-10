import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/glass_container.dart';

/// design_reference/user_login_minimalist_redesign.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  String _language = 'English';

  static const _languages = ['English', 'తెలుగు', 'हिंदी'];

  bool get _canSubmit => _phoneController.text.trim().length == 10;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (!_canSubmit) return;
    context.push('/otp', extra: _phoneController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.containerMargin),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.stackGapMd),
                    child: GlassContainer(
                      borderRadius: AppRadius.full,
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          for (final lang in _languages) _LanguageChip(
                            label: lang,
                            selected: _language == lang,
                            onTap: () => setState(() => _language = lang),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const AppLogo(size: 110, showWordmark: true),
                const SizedBox(height: AppSpacing.stackGapLg),
                GlassContainer(
                  borderRadius: 24,
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mobile Number',
                          style: AppTextStyles.labelMd
                              .copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 6),
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                        ),
                        child: Row(
                          children: [
                            Text('+91',
                                style: AppTextStyles.bodyLg
                                    .copyWith(color: AppColors.onSurfaceVariant)),
                            const SizedBox(width: 12),
                            Container(width: 1, height: 20, color: AppColors.outlineVariant),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                onChanged: (_) => setState(() {}),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  hintText: 'Enter 10 digit number',
                                ),
                                style: AppTextStyles.bodyLg,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.stackGapLg),
                      _SendOtpButton(enabled: _canSubmit, onPressed: _sendOtp),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.stackGapMd),
                TextButton(
                  onPressed: () => context.go('/home'),
                  child: Text(
                    'Skip for now',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.full),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            fontSize: 11,
            color: selected ? AppColors.primary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _SendOtpButton extends StatelessWidget {
  const _SendOtpButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: enabled ? onPressed : null,
          child: Ink(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.userAccentGreen],
              ),
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Send OTP',
                    style: AppTextStyles.titleMd.copyWith(color: Colors.white)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

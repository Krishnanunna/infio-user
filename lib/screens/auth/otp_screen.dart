import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/gradient_button.dart';

/// design_reference/user_otp_verification_minimalist_redesign.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.phoneNumber});

  final String? phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _controllers = List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {});
  }

  void _verify() {
    if (!_isComplete) return;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final maskedPhone = widget.phoneNumber != null
        ? '+91 ${widget.phoneNumber}'
        : '+91 XXXXX XXXXX';

    return Scaffold(
      appBar: const GlassAppBar(showBackButton: true, title: ''),
      body: AmbientBackground(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.containerMargin),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.stackGapMd),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
                  ),
                  child: const Icon(Icons.location_on, color: AppColors.primary, size: 32),
                ),
                const SizedBox(height: AppSpacing.stackGapLg),
                Text('Verification',
                    style: AppTextStyles.headlineLgMobile, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  'Enter the 4-digit code sent to $maskedPhone',
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.stackGapLg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 4; i++) ...[
                      if (i > 0) const SizedBox(width: AppSpacing.gridGutter),
                      _OtpBox(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        onChanged: (v) => _onChanged(i, v),
                        onBackspaceEmpty: () {
                          if (i > 0) _focusNodes[i - 1].requestFocus();
                        },
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.stackGapLg),
                GradientButton(
                  label: 'Verify',
                  icon: Icons.arrow_forward_outlined,
                  colors: const [AppColors.userAccentGreen, AppColors.primary],
                  onPressed: _isComplete ? _verify : null,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.stackGapMd),
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      children: [
                        const TextSpan(text: "Didn't receive code? "),
                        TextSpan(
                          text: 'Resend OTP',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspaceEmpty,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspaceEmpty;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: KeyboardListener(
        focusNode: FocusNode(skipTraversal: true),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspaceEmpty();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          onChanged: onChanged,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: AppTextStyles.displayLg,
          decoration: InputDecoration(
            counterText: '',
            isDense: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}

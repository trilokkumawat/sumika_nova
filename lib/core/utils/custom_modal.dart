import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/widget/appbutton.dart';

/// Success modal with icon, title, description and gradient CTA button.
class CustomModal extends StatelessWidget {
  const CustomModal({
    super.key,
    this.title = 'Password Update Successfully',
    this.message =
        'Password changed successfully, you can login again with new password',
    this.buttonText = 'Back to Login',
    required this.onPressed,
  });

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  static const Color _gradientStart = Color(0xFFE37A2A);
  static const Color _gradientEnd = Color(0xFFC31D69);
  static const Color _successOuter = Color(0xFF22C55E);
  static const Color _successInner = Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          spacing: 28,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSuccessIcon(),
            Column(
              spacing: 10,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TypographyFont.uih3bold.copyWith(
                    color: AppColor.gray9,
                  ),
                ),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TypographyFont.uih5reg.copyWith(
                    color: AppColor.gray11,
                  ),
                ),
              ],
            ),
            AppButton(text: buttonText, onPressed: onPressed),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _successOuter.withValues(alpha: 0.2),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _successInner,
            ),
          ),
          const Icon(Icons.check_rounded, size: 36, color: Colors.white),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

/// Button with gradient background: linear-gradient(180deg, #E37A2A 0%, #C31D69 100%).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 52,
    this.borderRadius = 12,
    this.textStyle,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;

  /// Gradient colors: top #E37A2A → bottom #C31D69 (180deg).
  static const Color _gradientStart = Color(0xFFE37A2A);
  static const Color _gradientEnd = Color(0xFFC31D69);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_gradientStart, _gradientEnd],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: Text(
                text,
                style:
                    textStyle ??
                    TypographyFont.uih5bold.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final TextStyle normalStyle;
  final TextStyle actionStyle;
  final VoidCallback onTap;

  const CustomRichText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.normalStyle,
    required this.actionStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: normalText, style: normalStyle),
          TextSpan(
            text: actionText,
            style: actionStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

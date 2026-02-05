import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({
    super.key,
    required this.title,
    this.onBack,
    this.trailingIcon,
    this.onTrailingTap,
    this.titleStyle,
    this.backgroundColor,
    this.iconColor,
    this.isAllowBack = false,
  });

  final String title;
  final VoidCallback? onBack;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isAllowBack;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColor.blue10;
    final iconClr = iconColor ?? AppColor.white;
    final style =
        titleStyle ?? TypographyFont.uih2bold.copyWith(color: AppColor.white);

    return Row(
      spacing: 10,
      children: [
        if (isAllowBack)
          GestureDetector(
            onTap: onBack ?? () => context.pop(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
              child: Icon(Icons.arrow_back, color: iconClr, size: 20),
            ),
          ),
        Expanded(
          child: Text(
            title.titleCase(),
            style: style,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailingIcon != null)
          GestureDetector(
            onTap: onTrailingTap,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
              child: Icon(trailingIcon, color: iconClr, size: 20),
            ),
          )
        else
          const SizedBox(width: 30, height: 30),
      ],
    );
  }
}

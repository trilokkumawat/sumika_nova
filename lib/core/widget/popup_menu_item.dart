import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class CustomPopupMenuItem extends StatelessWidget {
  const CustomPopupMenuItem({
    super.key,
    this.iconPath,
    this.icon,
    required this.label,
    required this.onTap,
  }) : assert(iconPath != null || icon != null,
            'Either iconPath or icon must be provided');

  final String? iconPath;
  final IconData? icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            if (icon != null)
              Icon(icon, size: 20, color: AppColor.black)
            else
              Image.asset(iconPath!, width: 20, height: 20, fit: BoxFit.contain),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TypographyFont.uih5reg.copyWith(color: AppColor.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

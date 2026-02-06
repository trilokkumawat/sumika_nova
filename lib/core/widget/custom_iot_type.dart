import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class CustomIotType extends StatelessWidget {
  const CustomIotType({
    super.key,
    required this.icon,
    required this.label,
    this.index,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.width = 47,
    this.padding = const EdgeInsets.all(10),
  });

  final IconData icon;
  final String label;
  final int? index;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final bg =
        backgroundColor ??
        (index != null
            ? (index!.isEven ? AppColor.white : AppColor.gray13)
            : AppColor.white);
    final iconClr = iconColor ?? AppColor.black;
    final txtClr = textColor ?? AppColor.black;

    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(color: bg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(icon, color: iconClr, size: 25),
          ),
          Text(label, style: TypographyFont.uih7reg.copyWith(color: txtClr)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({
    super.key,
    this.title = '',
    this.onBack,
    this.trailingIcon,
    this.onTrailingTap,
    this.titleStyle,
    this.backgroundColor,
    this.iconColor,
    this.isAllowBack = false,
    this.padding,
    this.isPopupmenu = false,
  });

  final String title;
  final VoidCallback? onBack;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isAllowBack;
  final EdgeInsets? padding;
  final bool isPopupmenu;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColor.blue10;
    final iconClr = iconColor ?? AppColor.white;
    final style =
        titleStyle ?? TypographyFont.uih2bold.copyWith(color: AppColor.white);

    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Row(
        spacing: 10,
        children: [
          if (isAllowBack)
            GestureDetector(
              onTap: onBack ?? () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child: Icon(Icons.arrow_back, color: iconClr, size: 24),
              ),
            ),
          if (title.isNotEmpty)
            Expanded(
              child: Text(
                title.titleCase(),
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (isPopupmenu)
            CustomPopup(
              position: PopupPosition.bottom,
              showArrow: true,
              arrowColor: Colors.white,
              barrierColor: Colors.black26,
              contentDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColor.gray3.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: 180,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _PopupMenuItem(
                      iconPath: 'assets/icons/plug.png',
                      label: 'Add Device',
                    ),
                    CustomDivider(context),
                    _PopupMenuItem(
                      iconPath: 'assets/icons/checkbox.png',
                      label: 'Create Scene',
                    ),
                    CustomDivider(context),
                    _PopupMenuItem(
                      iconPath: 'assets/icons/scan.png',
                      label: 'Scan',
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child: Icon(
                  trailingIcon ?? Icons.add,
                  color: iconClr,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PopupMenuItem extends StatelessWidget {
  const _PopupMenuItem({required this.iconPath, required this.label});

  final String iconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          Image.asset(iconPath, width: 20, height: 20, fit: BoxFit.contain),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TypographyFont.uih5med.copyWith(color: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}

CustomDivider(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.9,
          // height: 10,
          decoration: BoxDecoration(
            color: AppColor.primary,
            border: const Border(
              bottom: BorderSide(color: AppColor.gray12, width: 1.0),
            ),
          ),
        ),
      ),
    ],
  );
}

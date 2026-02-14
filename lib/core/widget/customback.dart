import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/custom_divider.dart';
import 'package:sumikanova/core/widget/popup_menu_item.dart';

class CustomBack extends StatefulWidget {
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
    this.onPopupMenuItemTap,
    this.isSubmit = false,
    this.onSubmit,
    this.submitIcon,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSubmit;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isAllowBack;
  final EdgeInsets? padding;
  final bool isPopupmenu;
  final void Function(int index)? onPopupMenuItemTap;
  final bool isSubmit;
  final Icon? submitIcon;
  @override
  State<CustomBack> createState() => _CustomBackState();
}

class _CustomBackState extends State<CustomBack> {
  void _onPopupItemTap(int index) {
    if (mounted) {
      Navigator.of(context).pop();
    }
    widget.onPopupMenuItemTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.backgroundColor ?? AppColor.blue10;
    final Color iconClr = widget.iconColor ?? AppColor.white;
    final TextStyle style =
        widget.titleStyle ??
        TypographyFont.uih2bold.copyWith(color: AppColor.white);

    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Row(
        spacing: 10,
        children: <Widget>[
          if (widget.isAllowBack)
            GestureDetector(
              onTap: widget.onBack ?? () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child: Icon(Icons.arrow_back, color: iconClr, size: 24),
              ),
            ),
          if (widget.title.isNotEmpty)
            Expanded(
              child: Text(
                widget.title.titleCase(),
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (widget.isSubmit)
            GestureDetector(
              onTap: widget.onSubmit ?? () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child:
                    widget.submitIcon ??
                    Icon(Icons.check, color: iconClr, size: 24),
              ),
            ),
          if (widget.isPopupmenu)
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
                    CustomPopupMenuItem(
                      iconPath: 'assets/icons/plug.png',
                      label: 'Add Device',
                      onTap: () => _onPopupItemTap(0),
                    ),
                    CustomDivider(),
                    CustomPopupMenuItem(
                      iconPath: 'assets/icons/checkbox.png',
                      label: 'Create Scene',
                      onTap: () => _onPopupItemTap(1),
                    ),
                    CustomDivider(),
                    CustomPopupMenuItem(
                      iconPath: 'assets/icons/scan.png',
                      label: 'Scan',
                      onTap: () => _onPopupItemTap(2),
                    ),
                    CustomDivider(),
                    CustomPopupMenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        _onPopupItemTap(3);
                        logout(context);
                      },
                    ),
                  ],
                ),
              ),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child: Icon(
                  widget.trailingIcon ?? Icons.add,
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

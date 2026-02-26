import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/homedropdown.dart';
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
    this.homeOptions,
    this.selectedHomeId,
    this.onHomeChanged,
    this.onCreateHomeTap,
    this.isTitleVisible = true,
    this.isHomeDropdownVisible = false,
  });

  /// When "Create Home" is tapped (empty list or last dropdown item), this is
  /// called. If null, defaults to pushing [RouteName.homeManagement].
  final Future<void> Function()? onCreateHomeTap;

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
  final bool isTitleVisible;
  final bool isHomeDropdownVisible;

  /// When non-null, a pill-shaped home dropdown (150px wide) is shown next to the title.
  /// Each map should have "id" (int) and "name" (String). Only name is shown in the dropdown.
  final List<Map<String, dynamic>>? homeOptions;
  final int? selectedHomeId;
  final ValueChanged<int?>? onHomeChanged;
  @override
  State<CustomBack> createState() => _CustomBackState();
}

class _CustomBackState extends State<CustomBack> {
  int? _localSelectedHomeId;

  int? get _effectiveSelectedHomeId =>
      widget.selectedHomeId ?? _localSelectedHomeId;

  void _onPopupItemTap(int index) {
    if (mounted) {
      Navigator.of(context).pop();
    }
    widget.onPopupMenuItemTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.backgroundColor ?? AppColor.bgbuttoncolor;
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
              onTap:
                  widget.onBack ??
                  () async {
                    context.pop();
                  },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
                child: Icon(Icons.arrow_back, color: iconClr, size: 24),
              ),
            ),
          if (widget.title.isNotEmpty)
            Expanded(
              child: Row(
                spacing: 10,
                children: [
                  if (widget.isTitleVisible == true)
                    Flexible(
                      child: Text(
                        widget.title.titleCase(),
                        style: style,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (widget.homeOptions != null &&
                      widget.isHomeDropdownVisible == true) ...[
                    HomeDropdown(
                      options: [
                        ...widget.homeOptions!,
                        {'id': -1, 'name': 'Create Home'},
                      ],
                      value: _effectiveSelectedHomeId == -1
                          ? null
                          : _effectiveSelectedHomeId,
                      onChanged: (id) async {
                        if (id == -1) {
                          await (widget.onCreateHomeTap ??
                              () async {
                                if (context.mounted) {
                                  await context.push(RouteName.homeManagement);
                                }
                              })();
                          return;
                        }
                        setState(() => _localSelectedHomeId = id);
                        widget.onHomeChanged?.call(id);
                      },
                      width: 150,
                    ),
                  ],
                  if (widget.homeOptions == null &&
                      widget.isHomeDropdownVisible == true) ...[
                    _CreateHomePill(
                      onTap: () async {
                        await (widget.onCreateHomeTap ??
                            () async {
                              if (context.mounted) {
                                await context.push(RouteName.homeManagement);
                              }
                            })();
                      },
                    ),
                  ],
                ],
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

class _CreateHomePill extends StatelessWidget {
  const _CreateHomePill({required this.onTap});

  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final bg = AppColor.blue1.withValues(alpha: 0.5);
    final textStyle = TypographyFont.uih5reg.copyWith(color: AppColor.white);
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: Platform.isIOS ? 35 : 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          'Create Home'.titleCase(),
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

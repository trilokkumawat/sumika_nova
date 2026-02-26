import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/app_logger.dart';
import 'package:sumikanova/core/utils/snackbar.dart';
import 'package:sumikanova/core/widget/customback.dart';

class CustomHeader extends StatefulWidget {
  final double appBarHeight;
  final bool isAllowBack;
  final bool isPopupmenu;
  final String title;
  final bool isSubmit;
  final VoidCallback? onSubmit;
  final Icon? submitIcon;
  final List<Map<String, dynamic>>? homeOptions;
  final int? selectedHomeId;
  final ValueChanged<int?>? onHomeChanged;
  final Future<void> Function()? onCreateHomeTap;
  final bool isTitleVisible;
  final bool isHomeDropdownVisible;
  const CustomHeader({
    super.key,
    this.appBarHeight = 0,
    this.isAllowBack = false,
    this.isPopupmenu = false,
    this.title = '',
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

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        width: double.infinity,
        height: Platform.isIOS ? 100 : 90,
        child: Container(
          decoration: BoxDecoration(color: AppColor.black),
          child: Stack(
            children: [
              Positioned(
                top: -90,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/icons/bgappbar.png',
                  fit: BoxFit.cover,
                  color: Color(0xFF353535),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Platform.isIOS ? 55 : 40),
                child: CustomBack(
                  isAllowBack: widget.isAllowBack,
                  isPopupmenu: widget.isPopupmenu,
                  title: widget.title,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  isSubmit: widget.isSubmit,
                  onSubmit: widget.onSubmit,
                  submitIcon: widget.submitIcon,
                  homeOptions: widget.homeOptions,
                  selectedHomeId: widget.selectedHomeId,
                  onHomeChanged: widget.onHomeChanged,
                  onCreateHomeTap: widget.onCreateHomeTap,
                  isTitleVisible: widget.isTitleVisible,
                  isHomeDropdownVisible: widget.isHomeDropdownVisible,
                  onPopupMenuItemTap: (int index) {
                    AppLogger.d('$index');
                    if (index == 0) {
                      context.push(RouteName.addDevice);
                    } else if (index == 1) {
                      SnackBarUtils.showSnackBar(
                        context,
                        'Create Scene feature is coming soon',
                      );
                    } else if (index == 2) {
                      SnackBarUtils.showSnackBar(
                        context,
                        'Scan feature is coming soon',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

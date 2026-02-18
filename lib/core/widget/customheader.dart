import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
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
          decoration: BoxDecoration(color: AppColor.primary),
          child: Stack(
            children: [
              Positioned(
                top: -90,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/icons/bgappbar.png',
                  fit: BoxFit.cover,
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
                  onPopupMenuItemTap: (int index) {
                    print(index);
                    if (index == 0) {
                      context.push(RouteName.addDevice);
                    } else if (index == 1) {
                      SnakBarUtils.showSnakBar(
                        context,
                        'Create Scene feature is coming soon',
                      );
                    } else if (index == 2) {
                      SnakBarUtils.showSnakBar(
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

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
  const CustomHeader({
    super.key,
    this.appBarHeight = 0,
    this.isAllowBack = false,
    this.isPopupmenu = false,
    this.title = '',
    this.isSubmit = false,
    this.onSubmit,
    this.submitIcon,
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
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Container(color: AppColor.primary),
            // Positioned.fill(
            //   child: Transform.rotate(
            //     angle: 3.141592653589793, // 180 degrees in radians
            //     child: Image.asset(
            //       'assets/icons/btmbg.png',
            //       height: widget.appBarHeight,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
                onPopupMenuItemTap: (int index) {
                  print(index);
                  if (index == 0) {
                    context.push(RouteName.addDevice);
                    // SnakBarUtils.showSnakBar(
                    //   context,
                    //   'Add Device feature is coming soon',
                    // );
                  } else if (index == 1) {
                    SnakBarUtils.showSnakBar(
                      context,
                      'Create Scene feature is coming soon',
                    );
                    // context.push(RouteName.createScene);
                  } else if (index == 2) {
                    // context.push(RouteName.scan);
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
    );
  }
}

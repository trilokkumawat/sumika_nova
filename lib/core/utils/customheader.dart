import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/widget/customback.dart';

class CustomHeader extends StatefulWidget {
  final double appBarHeight;
  final bool isAllowBack;
  final bool isPopupmenu;
  final String title;
  final bool isSubmit;
  final VoidCallback? onSubmit;

  const CustomHeader({
    super.key,
    this.appBarHeight = 0,
    this.isAllowBack = false,
    this.isPopupmenu = false,
    this.title = '',
    this.isSubmit = false,
    this.onSubmit,
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
        height: 110,
        child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Container(color: AppColor.primary),
            Positioned.fill(
              child: Transform.rotate(
                angle: 3.141592653589793, // 180 degrees in radians
                child: Image.asset(
                  'assets/icons/btmbg.png',
                  height: widget.appBarHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: CustomBack(
                isAllowBack: widget.isAllowBack,
                isPopupmenu: widget.isPopupmenu,
                title: widget.title,
                padding: EdgeInsets.symmetric(horizontal: 16),
                isSubmit: widget.isSubmit,
                onSubmit: widget.onSubmit,
                onPopupMenuItemTap: (int index) {
                  print(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

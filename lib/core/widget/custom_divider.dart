import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.height = 1,
    this.color,
    this.width,
  });

  final double height;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Color lineColor = color ?? AppColor.gray12;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: width ?? MediaQuery.sizeOf(context).width / 2.9,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: lineColor, width: height),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

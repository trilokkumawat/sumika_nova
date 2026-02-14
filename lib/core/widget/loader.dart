import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';

class CustomLoader extends StatefulWidget {
  final double? size;
  final double? strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  const CustomLoader({
    super.key,
    this.size,
    this.strokeWidth,
    this.color,
    this.backgroundColor,
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size ?? 25,
        height: widget.size ?? 25,
        child: CircularProgressIndicator(
          strokeWidth: widget.strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.color ?? AppColor.white,
          ),
          backgroundColor:
              widget.backgroundColor ?? AppColor.black.withOpacity(0.2),
        ),
      ),
    );
    ;
  }
}

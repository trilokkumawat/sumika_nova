import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class SnackBarUtils {
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? bgcolor,
    Color? textColor,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TypographyFont.uih5med.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
        backgroundColor: bgcolor ?? AppColor.primary,
        behavior: behavior ?? SnackBarBehavior.fixed,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class SnakBarUtils {
  static void showSnakBar(
    BuildContext context,
    String message, {
    Color? bgcolor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,

          style: TypographyFont.uih5med.copyWith(
            color: textColor ?? Colors.black,
          ),
        ),
        backgroundColor: bgcolor ?? AppColor.gray4,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}

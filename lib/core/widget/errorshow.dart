import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class CustomErrorShow extends StatefulWidget {
  final String errorMessage;
  const CustomErrorShow({super.key, required this.errorMessage});

  @override
  State<CustomErrorShow> createState() => _CustomErrorShowState();
}

class _CustomErrorShowState extends State<CustomErrorShow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.errorMessage,
          style: TypographyFont.uih5reg.copyWith(color: Colors.red.shade700),
        ),
      ],
    );
  }
}

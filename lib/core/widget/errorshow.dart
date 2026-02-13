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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        widget.errorMessage,
        style: TypographyFont.uih5reg.copyWith(color: Colors.red.shade700),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ImageColorFilterGress extends StatefulWidget {
  final Widget child;
  const ImageColorFilterGress({super.key, required this.child});

  @override
  State<ImageColorFilterGress> createState() => _ImageColorFilterGressState();
}

class _ImageColorFilterGressState extends State<ImageColorFilterGress> {
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.40,
        0.40,
        0.40,
        0,
        0, // Red coefficients
        0.40,
        0.40,
        0.40,
        0,
        0, // Green coefficients
        0.40,
        0.40,
        0.40,
        0,
        0, // Blue coefficients
        0,
        0,
        0,
        1,
        0, // Alpha unchanged
      ]),
      child: widget.child,
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/img_colorfilter.dart';

class SunsetCard extends StatefulWidget {
  const SunsetCard({
    super.key,
    required this.temperature,
    required this.dateLabel,
    this.weatherCircleAsset = 'assets/icons/weather_circle.png',
    this.sunAsset = 'assets/icons/sun.png',
    this.gradientColors,
    this.height,
    this.isday = false,
    this.isLoading = false,
  });

  final num temperature;
  final String dateLabel;
  final String weatherCircleAsset;
  final String sunAsset;
  final List<Color>? gradientColors;
  final double? height;
  final bool isday;
  final bool isLoading;

  @override
  State<SunsetCard> createState() => _SunsetCardState();
}

class _SunsetCardState extends State<SunsetCard> {
  double get _cardHeight => widget.height ?? 150;

  List<Color> get _gradientColors =>
      widget.gradientColors ??
      [
        Color(0xFF00D2FF).withValues(alpha: 0.59),
        Color(0xFF3A7BD5).withValues(alpha: 0.59),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ImageColorFilterGress(
        child: Container(
          width: double.infinity,
          height: Platform.isIOS ? _cardHeight : _cardHeight + 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: _gradientColors,
            ),
          ),
          child: widget.isLoading
              ? Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 50,
                      child: Image.asset(widget.weatherCircleAsset),
                    ),
                    Positioned(
                      top: -5,
                      left: 10,
                      right: 0,
                      child: Row(
                        spacing: 8,
                        children: [
                          Text(
                            '${widget.temperature.toStringAsFixed(widget.temperature == widget.temperature.round() ? 0 : 1)}°',
                            style: TypographyFont.uih1bold.copyWith(
                              color: AppColor.black,
                              fontSize: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width * 0.30,
                      child: Row(
                        spacing: 8,
                        children: [
                          Text(
                            widget.dateLabel,
                            style: TypographyFont.uih4reg.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 10,
                      child: Icon(
                        widget.isday ? Icons.sunny : Icons.nightlight_round,
                        size: 50,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

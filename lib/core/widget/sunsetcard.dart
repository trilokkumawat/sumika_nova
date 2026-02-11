import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class SunsetCard extends StatefulWidget {
  const SunsetCard({
    super.key,
    required this.temperature,
    required this.dateLabel,
    this.weatherCircleAsset = 'assets/icons/weather_circle.png',
    this.sunAsset = 'assets/icons/sun.png',
    this.gradientColors,
  });

  final num temperature;
  final String dateLabel;
  final String weatherCircleAsset;
  final String sunAsset;
  final List<Color>? gradientColors;

  @override
  State<SunsetCard> createState() => _SunsetCardState();
}

class _SunsetCardState extends State<SunsetCard> {
  static const double _cardHeight = 150;

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
      child: Container(
        width: double.infinity,
        height: _cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _gradientColors,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 50,
              child: Image.asset(widget.weatherCircleAsset),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.06,
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    '${widget.temperature.toStringAsFixed(widget.temperature == widget.temperature.round() ? 0 : 1)}°',
                    style: TypographyFont.uih1bold.copyWith(
                      color: AppColor.white,
                      fontSize: 64,
                    ),
                  ),
                  Text(
                    widget.dateLabel,
                    style: TypographyFont.uih4reg.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 15,
              child: Icon(Icons.sunny, size: 50, color: AppColor.white),
              //  Image.asset(widget.sunAsset, width: 100, height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class FocusLevelSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;

  const FocusLevelSlider({super.key, this.value = 50, this.onChanged});

  @override
  State<FocusLevelSlider> createState() => _FocusLevelSliderState();
}

class _FocusLevelSliderState extends State<FocusLevelSlider> {
  // Slider dimensions
  static const double _trackHeight = 8;
  static const double _startDotSize = 20;
  static const double _thumbSize = 20;
  static const double _glowSize = 20;
  static const double _labelHeight = 8;

  double _fraction = 0.5;

  double _toFraction(double v) => (v / 100).clamp(0.0, 1.0);

  double _toValue(double f) => (f * 100).roundToDouble();

  @override
  void initState() {
    super.initState();
    _fraction = _toFraction(widget.value);
  }

  @override
  void didUpdateWidget(covariant FocusLevelSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _fraction = _toFraction(widget.value);
    }
  }

  void _onDragUpdate(DragUpdateDetails details, double trackWidth) {
    final dx = details.localPosition.dx.clamp(0.0, trackWidth);
    setState(() {
      _fraction = dx / trackWidth;
    });
    widget.onChanged?.call(_toValue(_fraction));
  }

  void _onTapDown(TapDownDetails details, double trackWidth) {
    final dx = details.localPosition.dx.clamp(0.0, trackWidth);
    setState(() {
      _fraction = dx / trackWidth;
    });
    widget.onChanged?.call(_toValue(_fraction));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Slider area ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            height: _glowSize + _labelHeight + 4,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final trackWidth = constraints.maxWidth;
                final thumbX = _fraction * trackWidth;
                final displayValue = _toValue(_fraction).toInt();

                return GestureDetector(
                  onHorizontalDragUpdate: (d) => _onDragUpdate(d, trackWidth),
                  onTapDown: (d) => _onTapDown(d, trackWidth),
                  behavior: HitTestBehavior.opaque,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: _labelHeight + 4 + (_glowSize - _trackHeight) / 2,
                        left: 0,
                        child: Container(
                          width: trackWidth,
                          height: _trackHeight,
                          decoration: BoxDecoration(
                            color: AppColor.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(
                              _trackHeight / 2,
                            ),
                          ),
                        ),
                      ),

                      // ── Active track (left → thumb) ──
                      Positioned(
                        top: _labelHeight + 4 + (_glowSize - _trackHeight) / 2,
                        left: 0,
                        child: Container(
                          width: thumbX.clamp(0.0, trackWidth),
                          height: _trackHeight,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(
                              _trackHeight / 2,
                            ),
                          ),
                        ),
                      ),

                      // ── Start dot (blue circle + white border) ──
                      Positioned(
                        top: _labelHeight + 4 + (_glowSize - _startDotSize) / 2,
                        left: -_startDotSize / 2,
                        child: Container(
                          width: _startDotSize,
                          height: _startDotSize,
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),

                      // ── Thumb glow ──
                      Positioned(
                        top: _labelHeight + 4,
                        left: thumbX - _glowSize / 2,
                        child: Container(
                          width: _glowSize,
                          height: _glowSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.black.withOpacity(0.25),
                          ),
                        ),
                      ),

                      // ── Thumb circle (blue fill + white border) ──
                      Positioned(
                        top: _labelHeight + 4 + (_glowSize - _thumbSize) / 2,
                        left: thumbX - _thumbSize / 2,
                        child: Container(
                          width: _thumbSize,
                          height: _thumbSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.black,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.blue2.withOpacity(0.25),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ── Labels ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Low',
                style: TypographyFont.uih6reg.copyWith(
                  color: Color(0xFFA1A1A1),
                ),
              ),
              Text(
                'High',
                style: TypographyFont.uih6reg.copyWith(
                  color: Color(0xFFA1A1A1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

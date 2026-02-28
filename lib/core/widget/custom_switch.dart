import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    this.value = false,
    this.onChanged,
    this.width,
    this.height,
    this.orientation = Axis.vertical,
    this.onLabel = 'ON',
    this.offLabel = 'OFF',
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? width;
  final double? height;

  /// [Axis.vertical] for home-style (height dominant); [Axis.horizontal] for device row.
  final Axis orientation;
  final String onLabel;
  final String offLabel;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  double get _width =>
      widget.width ?? (widget.orientation == Axis.horizontal ? 52.0 : 35.0);
  double get _height =>
      widget.height ?? (widget.orientation == Axis.horizontal ? 28.0 : 50.0);
  static const Color _onColor = Color(0xFF17DB94);
  // static const Color _onColor = Color(0xFFffffff);

  late ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<bool>(widget.value);
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.value = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    _controller.value = !_controller.value;
    widget.onChanged?.call(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    final bool horizontal = widget.orientation == Axis.horizontal;
    return ValueListenableBuilder<bool>(
      valueListenable: _controller,
      builder: (context, isOn, _) {
        final Widget inner = GestureDetector(
          onTap: _toggle,
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(horizontal ? 6 : 5),
            ),
            child: horizontal ? _buildHorizontal(isOn) : _buildVertical(isOn),
          ),
        );
        if (horizontal) return inner;
        return Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: inner,
        );
      },
    );
  }

  Widget _buildVertical(bool isOn) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              widget.onLabel,
              style: TypographyFont.uih7bold.copyWith(
                color: isOn
                    ? AppColor.white
                    : AppColor.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              widget.offLabel,
              style: TypographyFont.uih7bold.copyWith(
                color: isOn
                    ? AppColor.white.withValues(alpha: 0.5)
                    : AppColor.white,
              ),
            ),
          ),
        ),
        AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isOn ? Alignment.bottomCenter : Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              width: _width + 50,
              height: (_height - 3) / 2,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColor.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontal(bool isOn) {
    const double thumbWidth = 22;
    const double thumbPadding = 3;
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  widget.onLabel,
                  style: TypographyFont.uih7bold.copyWith(
                    color: isOn
                        ? AppColor.white
                        : AppColor.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.offLabel,
                  style: TypographyFont.uih7bold.copyWith(
                    color: isOn
                        ? AppColor.white.withValues(alpha: 0.5)
                        : AppColor.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: thumbPadding,
              vertical: 3,
            ),
            child: Container(
              width: thumbWidth,
              height: _height - 6,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColor.black.withValues(alpha: 0.15),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

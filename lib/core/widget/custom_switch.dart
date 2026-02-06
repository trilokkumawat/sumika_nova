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
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? width;
  final double? height;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  double get _width => widget.width ?? 40.0;
  double get _height => widget.height ?? 50.0;
  static const Color _onColor = Color(0xFF17DB94);

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
    return Container(
      // padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _controller,
        builder: (context, isOn, _) {
          return GestureDetector(
            onTap: _toggle,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: isOn ? _onColor : AppColor.gray7,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'ON',
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
                        'OFF',
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
                    alignment: isOn
                        ? Alignment.bottomCenter
                        : Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        width: _width + 50,
                        height: (_height - 3) / 2,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular((8)),
                          boxShadow: [
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
              ),
            ),
          );
        },
      ),
    );
  }
}

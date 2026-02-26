import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/widget/custom_switch.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/focus_level_slider.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final String? deviceid;
  const DeviceDetailsScreen({super.key, required this.deviceid});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  static const List<Map<String, dynamic>> _devices = <Map<String, dynamic>>[
    {
      'id': '1',
      'iconPath': 'assets/icons/light.png',
      'hasSlider': true,
      'onLabel': 'ON',
      'offLabel': 'OFF',
      'toggleWidth': 52.0,
      'initialLevel': 55.0,
      'initialOn': true,
    },
    {
      'id': '2',
      'iconPath': 'assets/icons/light.png',
      'hasSlider': true,
      'onLabel': 'ON',
      'offLabel': 'OFF',
      'toggleWidth': 52.0,
      'initialLevel': 55.0,
      'initialOn': true,
    },
  ];

  late Map<String, double> _levels;
  late Map<String, bool> _toggles;

  @override
  void initState() {
    super.initState();
    _levels = <String, double>{
      for (final d in _devices)
        if (d['hasSlider'] == true)
          d['id'] as String: d['initialLevel'] as double,
    };
    _toggles = <String, bool>{
      for (final d in _devices) d['id'] as String: d['initialOn'] as bool,
    };
  }

  static const double _cardRadius = 12;

  Widget _deviceCard({
    required String iconPath,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: borderRadius ?? BorderRadius.circular(_cardRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.gray3.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(iconPath, width: 44, height: 44, fit: BoxFit.contain),
          const SizedBox(width: 16),
          Expanded(child: child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          CustomHeader(title: 'Device Details', isAllowBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/kitchenlarge.png',
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: AppColor.white,
                                  size: 20,
                                ),
                                Text(
                                  'Change',
                                  style: TypographyFont.uih6reg.copyWith(
                                    color: AppColor.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x40C7C6C6),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Kitchen',
                                style: TypographyFont.uih4med.copyWith(
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _devices.length,
                    itemBuilder: (final BuildContext context, final int index) {
                      final Map<String, dynamic> d = _devices[index];
                      final String id = d['id'] as String;
                      final bool hasSlider = d['hasSlider'] as bool;
                      final bool isFirst = index == 0;
                      final bool isLast = index == _devices.length - 1;
                      final BorderRadius radius = _devices.length == 1
                          ? BorderRadius.circular(_cardRadius)
                          : isFirst
                          ? BorderRadius.only(
                              topLeft: Radius.circular(_cardRadius),
                              topRight: Radius.circular(_cardRadius),
                            )
                          : isLast
                          ? BorderRadius.only(
                              bottomLeft: Radius.circular(_cardRadius),
                              bottomRight: Radius.circular(_cardRadius),
                            )
                          : BorderRadius.zero;
                      return Container(
                        // padding: const EdgeInsets.only(bottom: 20),
                        child: _deviceCard(
                          iconPath: d['iconPath'] as String,
                          borderRadius: radius,
                          child: Row(
                            mainAxisAlignment: hasSlider
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (hasSlider) ...[
                                Expanded(
                                  child: FocusLevelSlider(
                                    value: _levels[id] ?? 50,
                                    onChanged: (final double v) {
                                      setState(() => _levels[id] = v);
                                    },
                                  ),
                                ),
                              ],
                              CustomSwitch(
                                value: _toggles[id] ?? false,
                                onChanged: (final bool v) {
                                  setState(() => _toggles[id] = v);
                                },
                                orientation: Axis.horizontal,
                                width: (d['toggleWidth'] as num).toDouble(),
                                height: 28,
                                onLabel: d['onLabel'] as String,
                                offLabel: d['offLabel'] as String,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

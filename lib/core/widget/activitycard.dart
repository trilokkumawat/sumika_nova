import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class CustomActivityCard extends StatelessWidget {
  final String location;
  final String device;
  final bool isStatus;
  final String timeAgo;

  const CustomActivityCard({
    Key? key,
    required this.location,
    required this.device,
    required this.isStatus,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      elevation: 3,
      shadowColor: const Color(0x40C7C6C6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    location,
                    style: TypographyFont.uih5med.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      device,
                      style: TypographyFont.uih6med.copyWith(
                        color: AppColor.gray4,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      isStatus ? 'Turned on' : 'Turned off',
                      style: TypographyFont.uih5reg.copyWith(
                        color: isStatus ? AppColor.green : AppColor.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                timeAgo,
                style: TypographyFont.uih5med.copyWith(color: AppColor.gray4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

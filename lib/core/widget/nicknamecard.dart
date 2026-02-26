import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class NicknameCard extends StatelessWidget {
  const NicknameCard({super.key, this.displayName, this.onTap});

  /// Current user name from storage. If null or empty, shows "Tap to Set NickName".
  final String? displayName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = (displayName != null && displayName!.trim().isNotEmpty)
        ? displayName!.trim()
        : 'Tap to Set NickName';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      shadowColor: const Color(0x40C7C6C6),
      color: AppColor.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 10,
            children: [
              Image.asset('assets/icons/profile2.png', width: 50, height: 50),
              Expanded(
                child: Text(
                  label,
                  style: TypographyFont.uih5bold.copyWith(
                    color: AppColor.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Icon(
              //   Icons.arrow_forward_ios_outlined,
              //   size: 26,
              //   color: AppColor.gray4,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

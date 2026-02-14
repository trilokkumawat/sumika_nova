import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class NicknameCard extends StatefulWidget {
  const NicknameCard({super.key});

  @override
  State<NicknameCard> createState() => _NicknameCardState();
}

class _NicknameCardState extends State<NicknameCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      shadowColor: const Color(0x40C7C6C6),
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 10,
          children: [
            Image.asset('assets/icons/instaprofile.png'),
            Text(
              'Tap to Set NickName',
              style: TypographyFont.uih5bold.copyWith(color: AppColor.black),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 26,
              color: AppColor.gray4,
            ),
          ],
        ),
      ),
    );
  }
}

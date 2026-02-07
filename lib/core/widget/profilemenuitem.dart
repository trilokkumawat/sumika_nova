import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

class ProfileMenuItem {
  const ProfileMenuItem({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({required this.items});

  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray3.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) _buildDashedDivider(),
              InkWell(
                onTap: items[i].onTap,
                splashColor: AppColor.gray3.withValues(alpha: 0.3),
                highlightColor: AppColor.gray2.withValues(alpha: 0.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[i].label,
                        style: TypographyFont.uih4med.copyWith(
                          color: AppColor.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColor.gray4,
                        size: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const double dashWidth = 4;
          const double gap = 4;
          final int count = ((constraints.maxWidth + gap) / (dashWidth + gap))
              .floor()
              .clamp(1, 60);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              count * 2 - 1,
              (i) => i.isEven
                  ? Container(
                      width: dashWidth,
                      height: 1,
                      color: AppColor.gray3,
                    )
                  : const SizedBox(width: gap),
            ),
          );
        },
      ),
    );
  }
}

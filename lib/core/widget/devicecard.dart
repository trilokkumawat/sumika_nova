import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/img_colorfilter.dart';

class CustomDeviceCard extends StatelessWidget {
  const CustomDeviceCard({
    super.key,
    required this.device,
    required this.cardwidth,
    required this.cardheight,
    required this.isSelected,
    required this.onTap,
  });

  final Map<String, String> device;
  final double cardwidth;
  final double cardheight;
  final bool isSelected;
  final VoidCallback onTap;

  Widget _buildIcon(String icon) {
    final isNetworkUrl =
        icon.startsWith('http://') || icon.startsWith('https://');
    if (isNetworkUrl) {
      return ImageColorFilterGress(
        child: Image.network(
          icon,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) =>
              Icon(Icons.device_hub, size: 40, color: AppColor.gray6),
        ),
      );
    }
    return ImageColorFilterGress(
      child: Image.asset(
        icon,
        width: 40,
        height: 40,
        errorBuilder: (_, __, ___) =>
            Icon(Icons.device_hub, size: 40, color: AppColor.gray6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardwidth,
        height: cardheight,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40C7C6C6),
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildIcon(device['icon']!),
                      const SizedBox(height: 8),
                      Text(
                        device['label']!,
                        style: TypographyFont.uih5reg.copyWith(
                          color: AppColor.black,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColor.primary : AppColor.gray1,
                    border: isSelected
                        ? null
                        : Border.all(color: AppColor.gray4, width: 1.5),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 14,
                    color: isSelected ? AppColor.white : AppColor.gray4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

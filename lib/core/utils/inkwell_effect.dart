import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';

/// Wraps [child] with [Material] + [InkWell] so tap splash/highlight shows
/// even when there is no [Material] ancestor. Use anywhere you need a
/// visible ink effect (e.g. icon buttons, list tiles without Material).
class InkWellEffect extends StatelessWidget {
  const InkWellEffect({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.splashColor,
    this.highlightColor,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;

  static final BorderRadius _defaultBorderRadius = BorderRadius.circular(24);
  static Color get _defaultSplash => AppColor.primary.withOpacity(0.12);
  static Color get _defaultHighlight => AppColor.primary.withOpacity(0.06);

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? _defaultBorderRadius;
    return onTap == null
        ? SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator()),
          )
        : Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: radius),
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              splashColor: splashColor ?? _defaultSplash,
              highlightColor: highlightColor ?? _defaultHighlight,
              child: child,
            ),
          );
  }
}

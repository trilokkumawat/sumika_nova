import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';

/// Reusable pill-shaped home dropdown. Options are [{"id": int, "name": String}];
/// only the name is shown in the dropdown. Use [value] / [onChanged] with id.
///
/// Use anywhere by passing [backgroundColor], [textColor], [iconColor] to match
/// the context (e.g. header: light blue bg + white text; sheet: white bg + dark text).
class HomeDropdown extends StatelessWidget {
  const HomeDropdown({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.width = 150,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.dropdownColor,
    this.hintText = 'Home',
  });

  final List<Map<String, dynamic>> options;
  final int? value;
  final ValueChanged<int?> onChanged;
  final double width;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? dropdownColor;
  final String hintText;

  static const double _radius = 20;

  static int? _idFromMap(Map<String, dynamic> m) {
    final v = m['id'];
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  static String _nameFromMap(Map<String, dynamic> m) {
    final n = m['name']?.toString() ?? '';
    return n.trim().isEmpty ? 'Home' : n;
  }

  @override
  Widget build(BuildContext context) {
    final validOptions = options.where((m) => _idFromMap(m) != null).toList();
    if (validOptions.isEmpty) return const SizedBox.shrink();

    final selectedId = value;
    final hasValidSelection =
        selectedId != null &&
        validOptions.any((m) => _idFromMap(m) == selectedId);
    final displayValue = hasValidSelection
        ? selectedId
        : _idFromMap(validOptions.first);

    final bg = backgroundColor ?? AppColor.blue1.withValues(alpha: 0.5);
    final fg = textColor ?? AppColor.white;
    final iconClr = iconColor ?? AppColor.white;
    final menuBg = dropdownColor ?? AppColor.white;

    final textStyle = TypographyFont.uih5reg.copyWith(color: fg);

    return Container(
      // width: ,
      height: Platform.isIOS ? 35 : 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: displayValue,
          // isExpanded: true,
          hint: Center(
            child: Text(
              hintText.titleCase(),
              style: textStyle,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: iconClr,
            size: 24,
          ),
          dropdownColor: menuBg,
          selectedItemBuilder: (context) => validOptions
              .map(
                (m) => Center(
                  child: Text(
                    _nameFromMap(m).titleCase(),
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
          items: validOptions
              .map(
                (m) => DropdownMenuItem<int>(
                  value: _idFromMap(m),
                  child: Text(
                    _nameFromMap(m).titleCase(),
                    style: TypographyFont.uih5reg.copyWith(
                      color: AppColor.gray8,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

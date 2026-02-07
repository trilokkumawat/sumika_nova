import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

/// Custom dropdown styled like CustomTxtFormField: same border, colors, padding.
/// Uses dropdown_button2 only. Dynamic width/height and colors.
class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.hint,
    this.validator,
    this.width,
    this.height = 52,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.backgroundColor,
    this.hintColor,
    this.textColor,
    this.borderRadius = 12,
    this.contentPadding,
    this.enabled = true,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? Function(T?)? validator;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? backgroundColor;
  final Color? hintColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? contentPadding;
  final bool enabled;

  OutlineInputBorder _border(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding =
        contentPadding ??
        const EdgeInsets.symmetric(vertical: 16, horizontal: 16);
    final border = borderColor ?? AppColor.gray0;
    final fillColor =
        backgroundColor ?? (enabled ? Colors.white : AppColor.gray1);
    final hintStyle = TypographyFont.uih5med.copyWith(
      color: hintColor ?? (enabled ? AppColor.gray10 : AppColor.gray3),
    );
    final textStyle = TypographyFont.uih5reg.copyWith(
      color: textColor ?? (enabled ? AppColor.gray8 : AppColor.gray4),
    );

    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField2<T>(
        value: value,
        hint: hint != null ? Text(hint!, style: hintStyle) : null,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: padding,
          filled: true,
          fillColor: fillColor,
          isDense: true,
          border: _border(context, border),
          enabledBorder: _border(context, border),
          focusedBorder: _border(context, focusBorderColor ?? border),
          errorBorder: _border(context, errorBorderColor ?? AppColor.gray0),
          focusedErrorBorder: _border(
            context,
            errorBorderColor ?? AppColor.gray0,
          ),
          errorStyle: TypographyFont.uih7reg.copyWith(color: Colors.red),
        ),
        buttonStyleData: ButtonStyleData(
          height: height ?? 52,
          padding: padding,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColor.gray0),
            color: Colors.white,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          overlayColor: WidgetStateProperty.all(
            AppColor.gray1.withValues(alpha: 0.3),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: hintColor ?? AppColor.gray10,
            size: 24,
          ),
        ),
        style: textStyle,
      ),
    );
  }
}

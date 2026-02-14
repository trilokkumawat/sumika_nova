import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';

class PerfixTileDropdown<T> extends StatefulWidget {
  const PerfixTileDropdown({
    super.key,
    this.label,
    required this.options,
    this.optionLabels,
    this.value,
    this.onChanged,
    this.prefixAssetName = 'assets/icon/personperfix.svg',
    this.perfixhide = true, // true = visible, false = hidden
    this.suffixhide = true, // true = visible, false = hidden
    this.hintText,
    this.safeSetSate,
    this.compact = false,
    this.gray = false,
    this.readonly = false,
  });

  final String? label;
  final List<T> options;
  final List<String>? optionLabels; // optional 1:1 labels with options
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final void Function(VoidCallback)? safeSetSate;

  // prefix icon
  final String prefixAssetName;
  final bool perfixhide;

  // suffix (arrow) icon
  final bool suffixhide;

  // Visual style
  final bool compact; // smaller height/padding and label size
  final bool gray; // grayish background treatment
  final bool readonly; // disable interaction when true

  @override
  State<PerfixTileDropdown<T>> createState() => _PerfixTileDropdownState<T>();
}

class _PerfixTileDropdownState<T> extends State<PerfixTileDropdown<T>> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant PerfixTileDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  String _labelOf(T option) {
    final idx = widget.options.indexOf(option);
    if (idx >= 0 &&
        widget.optionLabels != null &&
        idx < widget.optionLabels!.length) {
      return widget.optionLabels![idx];
    }
    return option.toString();
  }

  /// Match CustomTxtFormField: inactive/focus border
  Color get _borderColor =>
      (widget.readonly || widget.gray) ? AppColor.gray4 : AppColor.gray0;

  /// Match CustomTxtFormField: default white, disabled gray1
  Color get _backgroundColor =>
      (widget.readonly || widget.gray) ? AppColor.gray1 : Colors.white;

  /// Match CustomTxtFormField: text gray8, disabled gray4
  Color get _textColor =>
      (widget.readonly || widget.gray) ? AppColor.gray4 : AppColor.gray8;

  /// Match CustomTxtFormField: hint gray10, disabled gray3
  Color get _hintColor =>
      (widget.readonly || widget.gray) ? AppColor.black : AppColor.black;

  /// Match CustomTxtFormField: icon gray10, disabled gray3
  Color get _iconColor =>
      (widget.readonly || widget.gray) ? AppColor.gray3 : AppColor.gray10;

  static const double _borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty)
          Text(widget.label!, style: TypographyFont.uih5med),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(_borderRadius),
            boxShadow: [
              BoxShadow(
                color: const Color(0x40C7C6C6), // #C7C6C6 with 0x40 alpha
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    hint: widget.hintText != null
                        ? Text(
                            widget.hintText!,
                            style: TypographyFont.uih5reg.copyWith(
                              color: _hintColor,
                            ),
                          )
                        : null,
                    value: _value,
                    isExpanded: true,
                    icon: widget.suffixhide && !widget.readonly
                        ? Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColor.gray4,
                            size: 25,
                          )
                        : const SizedBox.shrink(),
                    dropdownColor: Colors.white,
                    selectedItemBuilder: (context) {
                      return widget.options.map((opt) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                _labelOf(opt),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TypographyFont.uih5reg.copyWith(
                                  color: _textColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                    items: widget.options
                        .map(
                          (opt) => DropdownMenuItem<T>(
                            value: opt,
                            child: Text(
                              _labelOf(opt),
                              style: TypographyFont.uih5reg.copyWith(
                                color: AppColor.gray8,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: widget.readonly
                        ? null
                        : (val) {
                            widget.safeSetSate!(() {
                              _value = val;
                              widget.onChanged?.call(val);
                            });
                          },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

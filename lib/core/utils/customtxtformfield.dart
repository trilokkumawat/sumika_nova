import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';

enum FieldState { inactive, focus, error, disabled }

class CustomTxtFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final bool obscureText; // Enable password mode
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool autofocus;
  final IconData? prefixIcon; // Prefix icon (hidden by default if null)
  final IconData? suffixIcon; // Custom suffix icon (hidden by default if null)
  final VoidCallback? onSuffixIconTap; // Callback for suffix icon tap
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final bool showPrefixIcon; // Control prefix icon visibility
  final bool showSuffixIcon; // Control suffix icon visibility
  final double? height;
  final TextCapitalization? textCapitalization; // Text capitalization mode

  const CustomTxtFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.borderRadius,
    this.contentPadding,
    this.showPrefixIcon = false, // Default hidden
    this.showSuffixIcon = false, // Default hidden
    this.height,
    this.textCapitalization,
  });

  @override
  State<CustomTxtFormField> createState() => _CustomTxtFormFieldState();
}

class _CustomTxtFormFieldState extends State<CustomTxtFormField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;
  String? _errorMessage;
  bool _hasBeenFocused = false;
  bool _hasBeenValidated = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_onTextChanged);
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _handleFocusChange() {
    final wasFocused = _isFocused;
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    // When field gains focus
    if (_isFocused && !wasFocused) {
      _hasBeenFocused = true;
      // Validate immediately if there's text and validator
      if (_controller.text.isNotEmpty && widget.validator != null) {
        _validateField(_controller.text);
      }
    }

    // When field loses focus - always validate
    if (!_isFocused && wasFocused) {
      if (widget.validator != null) {
        _validateField(_controller.text);
      } else {
        // Clear error if no validator
        setState(() {
          _errorMessage = null;
          _hasBeenValidated = false;
        });
      }
    }
  }

  void _onTextChanged() {
    // Auto-validate if:
    // 1. Field has been focused at least once, OR
    // 2. Field has been validated before
    if ((_hasBeenFocused || _hasBeenValidated) && widget.validator != null) {
      _validateField(_controller.text);
    }

    widget.onChanged?.call(_controller.text);
  }

  String? _validateField(String? value) {
    if (widget.validator != null) {
      _hasBeenValidated = true;
      final error = widget.validator!(value);
      // Update state to reflect validation result
      setState(() {
        _errorMessage = error;
      });
      return error;
    }
    // If no validator, clear any existing error
    if (_errorMessage != null) {
      setState(() {
        _errorMessage = null;
      });
    }
    return null;
  }

  FieldState get _fieldState {
    if (!widget.enabled || widget.readOnly) {
      return FieldState.disabled;
    }

    // Error state takes priority (only if validated and has error)
    // Error state shows even when focused to give immediate feedback
    if (_hasBeenValidated && _errorMessage != null) {
      return FieldState.error;
    }

    // Focus state when field is focused and no error
    if (_isFocused) {
      return FieldState.focus;
    }

    // Inactive state when not focused and no error
    return FieldState.inactive;
  }

  Color _getBorderColor() {
    if (widget.borderColor != null && _fieldState == FieldState.inactive) {
      return widget.borderColor!;
    }
    if (widget.focusBorderColor != null && _fieldState == FieldState.focus) {
      return widget.focusBorderColor!;
    }
    if (widget.errorBorderColor != null && _fieldState == FieldState.error) {
      return widget.errorBorderColor!;
    }

    switch (_fieldState) {
      case FieldState.focus:
        return AppColor.gray0;
      case FieldState.error:
        return AppColor.gray0;
      case FieldState.disabled:
        return AppColor.gray4;
      case FieldState.inactive:
        return AppColor.gray0;
    }
  }

  Color _getTextColor() {
    if (widget.textColor != null) {
      return widget.textColor!;
    }
    switch (_fieldState) {
      case FieldState.disabled:
        return AppColor.gray4;
      case FieldState.inactive:
        return AppColor.gray10;
      default:
        return AppColor.gray8;
    }
  }

  Color _getHintColor() {
    if (widget.hintColor != null) {
      return widget.hintColor!;
    }
    switch (_fieldState) {
      case FieldState.disabled:
        return AppColor.gray3;
      default:
        return AppColor.gray10;
    }
  }

  Color _getBackgroundColor() {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }
    switch (_fieldState) {
      case FieldState.disabled:
        return AppColor.gray1;
      default:
        return Colors.white;
    }
  }

  Color _getIconColor() {
    switch (_fieldState) {
      case FieldState.disabled:
        return AppColor.gray3;

      default:
        return AppColor.gray10;
    }
  }

  Widget? _buildPrefixIcon() {
    if (!widget.showPrefixIcon || widget.prefixIcon == null) {
      return null;
    }
    return Icon(widget.prefixIcon, size: 20, color: _getIconColor());
  }

  Widget? _buildSuffixIcon() {
    // Password visibility toggle (takes priority if obscureText is true)
    if (widget.obscureText) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 24,
          color: _getIconColor(),
        ),
      );
    }

    // Custom suffix icon (only shown if showSuffixIcon is true)
    if (widget.showSuffixIcon && widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixIconTap,
        child: Icon(widget.suffixIcon, size: 20, color: _getIconColor()),
      );
    }

    return null;
  }

  OutlineInputBorder _getBorder([Color? borderColor]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
      borderSide: BorderSide(color: borderColor ?? _getBorderColor(), width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: widget.enabled && !widget.readOnly,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            validator: _validateField,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText && _obscureText,
            obscuringCharacter: '•',
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            autofocus: widget.autofocus,

            style: TypographyFont.uih5reg.copyWith(color: _getTextColor()),
            decoration: InputDecoration(
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              // label: widget.labelText != null
              //     ? Text(
              //         widget.labelText!,
              //         style: TypographyFont.uih5reg.copyWith(
              //           color: _getTextColor(),
              //         ),
              //       )
              //     : null,
              hintText: widget.hintText,
              hintStyle: TypographyFont.uih5med.copyWith(
                color: _getHintColor(),
              ),
              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(),
              filled: true,
              fillColor: _getBackgroundColor(),
              isDense: true,
              border: _getBorder(),
              enabledBorder: _getBorder(),
              focusedBorder: _getBorder(),
              disabledBorder: _getBorder(),
              errorBorder: _getBorder(),
              focusedErrorBorder: _getBorder(),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
          ),
        ),
        if (_errorMessage != null && _hasBeenValidated) ...[
          const SizedBox(height: 4),
          Text(
            _errorMessage!.sentenceCase(),
            style: TypographyFont.uih7reg.copyWith(color: Colors.red),
          ),
        ],
      ],
    );
  }
}

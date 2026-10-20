import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final bool expands;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? iconColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.expands = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.hintStyle,
    this.fillColor,
    this.iconColor,
    this.borderRadius = 15,
    this.contentPadding,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      expands: expands,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
      style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        helperText: helperText,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon == null
            ? prefix
            : Icon(prefixIcon, color: iconColor ?? const Color(0xffffc107)),
        suffixIcon: suffixIcon ?? suffix,
        filled: true,
        fillColor: fillColor ?? const Color(0xff171717),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: Colors.white.withOpacity(.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Color(0xffffc107), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}

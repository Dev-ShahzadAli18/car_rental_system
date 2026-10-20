import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final double? width;
  final double? height;
  final double? radius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final IconData? icon;
  final Widget? iconWidget;
  final bool iconRight;
  final TextStyle? textStyle;
  final bool loading;
  final double loadingSize;

  const CustomElevatedButton({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledColor,
    this.width,
    this.height = 55,
    this.radius = 15,
    this.elevation = 0,
    this.padding,
    this.borderSide,
    this.icon,
    this.iconWidget,
    this.iconRight = false,
    this.textStyle,
    this.loading = false,
    this.loadingSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (loading) {
      content = SizedBox(
        width: loadingSize,
        height: loadingSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: foregroundColor ?? Colors.black,
        ),
      );
    } else if (child != null) {
      content = child!;
    } else {
      final Widget textWidget = Text(
        text ?? "",
        style:
            textStyle ??
            const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );

      final Widget? buttonIcon =
          iconWidget ?? (icon == null ? null : Icon(icon));

      if (buttonIcon == null) {
        content = textWidget;
      } else {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: iconRight
              ? [textWidget, const SizedBox(width: 8), buttonIcon]
              : [buttonIcon, const SizedBox(width: 8), textWidget],
        );
      }
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xffffc107),
          foregroundColor: foregroundColor ?? Colors.black,
          disabledBackgroundColor: disabledColor ?? Colors.grey.shade700,
          elevation: elevation,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        child: content,
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;
  final IconData? icon;
  final bool iconRight;
  final TextStyle? textStyle;
  const CustomOutlinedButton({
    super.key,
    this.text,
    this.child,
    this.onTap,
    this.borderColor,
    this.foregroundColor,
    this.backgroundColor,
    this.width,
    this.height = 55,
    this.radius = 15,
    this.icon,
    this.iconRight = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text ?? "",
      style: textStyle ?? const TextStyle(fontWeight: FontWeight.w600),
    );
    Widget content = child ?? textWidget;
    if (child == null && icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: iconRight
            ? [textWidget, const SizedBox(width: 8), Icon(icon)]
            : [Icon(icon), const SizedBox(width: 8), textWidget],
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? Colors.white,
          side: BorderSide(color: borderColor ?? Colors.white24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        child: content,
      ),
    );
  }
}


class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final IconData? icon;
  final bool iconRight;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.textColor,
    this.backgroundColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.icon,
    this.iconRight = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: TextStyle(
        color: textColor ?? const Color(0xffffc107),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );

    Widget content = textWidget;

    if (icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: iconRight
            ? [
                textWidget,
                const SizedBox(width: 5),
                Icon(icon, size: 18, color: textColor),
              ]
            : [
                Icon(icon, size: 18, color: textColor),
                const SizedBox(width: 5),
                textWidget,
              ],
      );
    }

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      child: content,
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;
  final double? iconSize;
  final double? radius;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    this.icon,
    this.child,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.size = 45,
    this.iconSize = 22,
    this.radius = 12,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        icon: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(radius!),
          ),
          child:
              child ??
              Icon(icon, size: iconSize, color: iconColor ?? Colors.white),
        ),
      ),
    );
  }
}

class CustomTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? textColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  const CustomTabButton({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
    this.selectedColor,
    this.selectedTextColor,
    this.textColor,
    this.radius = 11,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius!),
        child: Container(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: selected
                ? selectedColor ?? const Color(0xffffc107)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(radius!),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? selectedTextColor ?? Colors.black
                  : textColor ?? Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

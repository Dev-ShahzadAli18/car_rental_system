import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const CustomContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: borderRadius ?? BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}

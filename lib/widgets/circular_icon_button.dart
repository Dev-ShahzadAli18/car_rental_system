import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final Color? borderColor;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 42,
    this.iconSize = 20,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.textPrimary,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? AppColors.cardBorder,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

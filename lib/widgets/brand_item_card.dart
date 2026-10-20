import 'package:flutter/material.dart';
import '../models/brand_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

enum BrandCardStyle {
  circle, // Home screen circle icon with label below
  pill,   // Search screen pill button
}

class BrandItemCard extends StatelessWidget {
  final BrandModel brand;
  final bool isSelected;
  final VoidCallback onTap;
  final BrandCardStyle style;

  const BrandItemCard({
    super.key,
    required this.brand,
    required this.isSelected,
    required this.onTap,
    this.style = BrandCardStyle.circle,
  });

  @override
  Widget build(BuildContext context) {
    if (style == BrandCardStyle.pill) {
      return _buildPillVariant();
    }
    return _buildCircleVariant();
  }

  // Home Screen Circle Variant
  Widget _buildCircleVariant() {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryDark : AppColors.primaryDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                brand.fallbackIcon ?? Icons.directions_car,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            brand.name,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Search Screen Pill Variant
  Widget _buildPillVariant() {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.primaryDark : AppColors.cardBorder,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (brand.fallbackIcon != null) ...[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.black87,
                ),
                child: Icon(
                  brand.fallbackIcon,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              brand.name,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

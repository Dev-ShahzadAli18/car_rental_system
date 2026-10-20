import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewsCount;
  final bool showStarIcon;

  const RatingBadge({
    super.key,
    required this.rating,
    this.reviewsCount,
    this.showStarIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        if (showStarIcon) ...[
          const SizedBox(width: 4),
          const Icon(
            Icons.star_rounded,
            color: AppColors.starOrange,
            size: 18,
          ),
        ],
        if (reviewsCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewsCount+Reviews)',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

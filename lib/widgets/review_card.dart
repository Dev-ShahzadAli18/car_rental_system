import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final String rating;
  final String comment;
  final String avatar;
  final double width;

  const ReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.comment,
    required this.avatar,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(avatar),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                rating,
                style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.star_rounded, size: 14, color: AppColors.starOrange),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

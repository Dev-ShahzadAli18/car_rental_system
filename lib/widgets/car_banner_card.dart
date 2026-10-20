import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';

class CarBannerCard extends StatelessWidget {
  final CarModel car;
  final VoidCallback onTap;

  const CarBannerCard({
    super.key,
    required this.car,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFEBECEF),
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        ),
        child: Stack(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    car.name,
                    style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        car.rating.toStringAsFixed(1),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: AppColors.starOrange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${car.pricePerDay.toInt()}/Day',
                    style: AppTextStyles.priceTag,
                  ),
                ],
              ),
            ),

            Positioned(
              right: 10,
              bottom: 6,
              top: 6,
              width: 170,
              child: Image.network(
                car.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.directions_car,
                  size: 60,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

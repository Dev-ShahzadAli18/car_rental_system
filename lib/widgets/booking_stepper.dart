import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class BookingStepper extends StatelessWidget {
  final int currentStep; // 0: Booking details, 1: Payment methods, 2: Confirmation

  const BookingStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStepIndicator(0),
            _buildConnectingLine(currentStep >= 1),
            _buildStepIndicator(1),
            _buildConnectingLine(currentStep >= 2),
            _buildStepIndicator(2),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Booking details',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 0 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep >= 0 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            Text(
              'Payment methods',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 1 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep >= 1 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            Text(
              'confirmation',
              style: AppTextStyles.caption.copyWith(
                fontWeight: currentStep == 2 ? FontWeight.w700 : FontWeight.w500,
                color: currentStep >= 2 ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator(int step) {
    final bool isCompleted = currentStep > step;
    final bool isActive = currentStep == step;

    if (isCompleted) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      );
    }

    if (isActive) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      );
    }

    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        color: Color(0xFFD3D6DC),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildConnectingLine(bool isFilled) {
    return Container(
      width: 90,
      height: 2.5,
      color: isFilled ? AppColors.primaryDark : const Color(0xFFD3D6DC),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class BookingStepper extends StatelessWidget {
  final int currentStep; 

  const BookingStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildStepIndicator(0),
              _buildConnectingLine(currentStep >= 1),
              _buildStepIndicator(1),
              _buildConnectingLine(currentStep >= 2),
              _buildStepIndicator(2),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                'Booking details',
                textAlign: TextAlign.left,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: currentStep == 0 ? FontWeight.w700 : FontWeight.w500,
                  color: currentStep >= 0 ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Payment methods',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: currentStep == 1 ? FontWeight.w700 : FontWeight.w500,
                  color: currentStep >= 1 ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'confirmation',
                textAlign: TextAlign.right,
                style: AppTextStyles.caption.copyWith(
                  fontWeight: currentStep == 2 ? FontWeight.w700 : FontWeight.w500,
                  color: currentStep >= 2 ? AppColors.textPrimary : AppColors.textSecondary,
                ),
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
    return Expanded(
      child: Container(
        height: 2.5,
        color: isFilled ? AppColors.primaryDark : const Color(0xFFD3D6DC),
      ),
    );
  }
}

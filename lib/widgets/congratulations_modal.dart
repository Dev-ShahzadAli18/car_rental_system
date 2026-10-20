import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';

class CongratulationsModal extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CongratulationsModal({
    super.key,
    this.title = 'Congratulations',
    this.message = 'Your car is ready for booking. Your booking has been successfully confirmed. Get ready to start your journey.',
    this.buttonText = 'Back to Home',
    required this.onButtonPressed,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Congratulations',
    String message = 'Your car is ready for booking. Your booking has been successfully confirmed. Get ready to start your journey.',
    String buttonText = 'Back to Home',
    VoidCallback? onButtonPressed,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CongratulationsModal(
        title: title,
        message: message,
        buttonText: buttonText,
        onButtonPressed: onButtonPressed ?? () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF4DE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.celebration_rounded,
                color: Color(0xFFFFB800),
                size: 44,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTextStyles.headingMedium.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: onButtonPressed,
            child: Container(
              height: 54,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(27),
                boxShadow: AppConstants.buttonShadow,
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: AppTextStyles.button.copyWith(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

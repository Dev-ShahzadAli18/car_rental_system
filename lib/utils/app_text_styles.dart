import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 15,
    color: AppColors.grey,
  );

  static const TextStyle body = TextStyle(fontSize: 14, color: AppColors.white);

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

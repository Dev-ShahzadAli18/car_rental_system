import 'package:car_rental_system/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  final PageController pageController = PageController();

  int currentPage = 0;

  void nextPage(BuildContext context, int totalPages) {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      skipToLogin(context);
    }
  }

  void skipToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void changePage(int index) {
    currentPage = index;
  }

  void dispose() {
    pageController.dispose();
  }
}

import 'package:car_rental_system/screens/Auth/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  PageController pageController = PageController();

  int currentPage = 0;

  void nextPage(BuildContext context, int totalPages) {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  void changePage(int index) {
    currentPage = index;
  }

  void dispose() {
    pageController.dispose();
  }
}

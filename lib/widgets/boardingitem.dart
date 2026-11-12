import 'package:flutter/material.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;
  final IconData fallbackIcon;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
    this.fallbackIcon = Icons.directions_car_filled_rounded,
  });
}

List<OnboardingItem> onboardingList = [
  OnboardingItem(
    image: 'https://purepng.com/public/uploads/large/purepng.com-white-ferrari-carcarferrarivehicletransport-961524653637e1uha.png',
    title: 'Find Your Dream Car',
    description:
        'Choose from a wide range of premium, high-performance, and luxury cars for your journey.',
    fallbackIcon: Icons.directions_car_filled_rounded,
  ),
  OnboardingItem(
    image: 'https://pngimg.com/d/tesla_car_PNG23.png',
    title: 'Book With Ease',
    description:
        'Select your favorite car, choose rental dates, and complete your booking in just a few taps.',
    fallbackIcon: Icons.electric_car_rounded,
  ),
  OnboardingItem(
    image: 'https://pngimg.com/d/lamborghini_PNG102905.png',
    title: 'Start Your Journey',
    description:
        'Pick up your car smoothly and enjoy an extraordinary, comfortable, and reliable driving experience.',
    fallbackIcon: Icons.speed_rounded,
  ),
];

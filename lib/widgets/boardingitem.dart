class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
List<OnboardingItem> onboardingList = [
  OnboardingItem(
    image: 'assets/images/car1.png',
    title: 'Find Your Dream Car',
    description:
        'Choose from a wide range of premium and comfortable cars for your journey.',
  ),
  OnboardingItem(
    image: 'assets/images/car2.png',
    title: 'Book With Ease',
    description:
        'Select your favorite car and book your ride in just a few taps.',
  ),
  OnboardingItem(
    image: 'assets/images/car3.png',
    title: 'Start Your Journey',
    description: 'Pick up your car and enjoy a smooth and comfortable journey.',
  ),
];

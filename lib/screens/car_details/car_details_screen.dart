import 'package:flutter/material.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/car_feature_card.dart';
import '../../widgets/circular_icon_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/rating_stars.dart';
import '../../widgets/review_card.dart';
import '../booking/booking_details_screen.dart';
import '../communication/chat_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarModel car;

  const CarDetailsScreen({
    super.key,
    required this.car,
  });

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final int _currentImageIndex = 0;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.car.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Car Details',
        onOptionsTap: () {},
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Car Image Carousel Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Image.network(
                            car.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => const Icon(
                              Icons.directions_car,
                              size: 100,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),

                      // Heart Favorite Button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                              widget.car.isFavorite = _isFavorite;
                            });
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              size: 22,
                              color: _isFavorite ? AppColors.red : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final bool isSelected = _currentImageIndex == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 18 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryDark : const Color(0xFFD3D6DC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // Details White Container Card
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 20,
                        offset: Offset(0, -6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Name & Rating Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car.name,
                                  style: AppTextStyles.title.copyWith(fontSize: 20),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  car.description ?? 'A car with high specs that are rented at an affordable price.',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingBadge(rating: car.rating),
                              const SizedBox(height: 4),
                              Text(
                                '(${car.reviewsCount}+Reviews)',
                                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: AppColors.divider, thickness: 1.2),
                      const SizedBox(height: 16),

                      // Host / Owner Row
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(car.ownerAvatar),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  car.ownerName,
                                  style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.accentBlue,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          // Phone Call Action
                          CircularIconButton(
                            icon: Icons.phone_outlined,
                            onTap: () {},
                          ),
                          const SizedBox(width: 10),
                          // Chat Message Action
                          CircularIconButton(
                            icon: Icons.chat_bubble_outline_rounded,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    contactName: car.ownerName,
                                    contactAvatar: car.ownerAvatar,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Car Features Heading
                      Text(
                        'Car features',
                        style: AppTextStyles.titleSmall.copyWith(fontSize: 17),
                      ),
                      const SizedBox(height: 14),

                      // 3x2 Grid of Features using CarFeatureCard
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.95,
                        children: [
                          CarFeatureCard(
                            icon: Icons.airline_seat_recline_normal_rounded,
                            title: 'Capacity',
                            value: '${car.seats} Seats',
                          ),
                          CarFeatureCard(
                            icon: Icons.power_outlined,
                            title: 'Engine Out',
                            value: car.engineOutput ?? '670 HP',
                          ),
                          CarFeatureCard(
                            icon: Icons.speed_rounded,
                            title: 'Max Speed',
                            value: car.maxSpeed ?? '250km/h',
                          ),
                          CarFeatureCard(
                            icon: Icons.album_rounded,
                            title: 'Advance',
                            value: car.autopilotType ?? 'Autopilot',
                          ),
                          CarFeatureCard(
                            icon: Icons.bolt_rounded,
                            title: 'Single Charge',
                            value: car.singleChargeOrFuel ?? '405 Miles',
                          ),
                          const CarFeatureCard(
                            icon: Icons.local_parking_rounded,
                            title: 'Advance',
                            value: 'Auto Parking',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Review Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Review (${car.reviewsCount})',
                            style: AppTextStyles.titleSmall.copyWith(fontSize: 17),
                          ),
                          Text(
                            'See All',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Review Cards Carousel using ReviewCard
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ReviewCard(
                              name: 'Mr. Jack',
                              rating: '5.0',
                              comment: 'The rental car was clean, reliable, and the service was quick and efficient.',
                              avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
                            ),
                            SizedBox(width: 14),
                            ReviewCard(
                              name: 'Robert',
                              rating: '5.0',
                              comment: 'Smooth drive, battery lasted throughout my whole trip. Highly recommended!',
                              avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pinned Bottom Button: "Book Now ->"
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BookingDetailsScreen(car: car),
                  ),
                );
              },
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: AppConstants.buttonShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Book Now',
                      style: AppTextStyles.button.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/brand_model.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/brand_item_card.dart';
import '../../widgets/car_banner_card.dart';
import '../../widgets/car_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/rating_stars.dart';
import '../../widgets/section_header.dart';

class DesignSystemPreviewScreen extends StatefulWidget {
  const DesignSystemPreviewScreen({super.key});

  @override
  State<DesignSystemPreviewScreen> createState() => _DesignSystemPreviewScreenState();
}

class _DesignSystemPreviewScreenState extends State<DesignSystemPreviewScreen> {
  int _selectedNavIndex = 0;
  String _selectedBrand = 'all';

  @override
  Widget build(BuildContext context) {
    final sampleCar = mockBestCars.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Design System & UI Kit',
        onOptionsTap: () {},
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Home App Bar
            const SectionHeader(title: '1. Home App Bar Variant'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: CustomAppBar(
                type: AppBarType.home,
                notificationCount: 3,
                onNotificationTap: () {},
                onAvatarTap: () {},
              ),
            ),
            const SizedBox(height: 24),

            // Section 2: Search Bar & Filter
            const SectionHeader(title: '2. Custom Search Bar & Filter Action'),
            const SizedBox(height: 12),
            CustomSearchBar(
              onFilterTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter tapped!')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Section 3: Brand Category Items
            const SectionHeader(title: '3. Brand Category Circles (Home Screen)'),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mockBrands.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final brand = mockBrands[index];
                  return BrandItemCard(
                    brand: brand,
                    isSelected: _selectedBrand == brand.id,
                    onTap: () => setState(() => _selectedBrand = brand.id),
                    style: BrandCardStyle.circle,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            const SectionHeader(title: '3b. Brand Pills (Search Screen)'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: mockBrands.map((brand) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BrandItemCard(
                      brand: brand,
                      isSelected: _selectedBrand == brand.id,
                      onTap: () => setState(() => _selectedBrand = brand.id),
                      style: BrandCardStyle.pill,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Section 4: Car Cards
            const SectionHeader(title: '4. Car Cards (Best Cars - Home & Search)'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CarCard(
                    car: sampleCar,
                    onTap: () {},
                    onFavoriteToggle: () {
                      setState(() => sampleCar.isFavorite = !sampleCar.isFavorite);
                    },
                  ),
                  const SizedBox(width: 16),
                  CarCard(
                    car: mockBestCars[1],
                    showBookNowButton: true,
                    onTap: () {},
                    onBookNow: () {},
                    onFavoriteToggle: () {
                      setState(() => mockBestCars[1].isFavorite = !mockBestCars[1].isFavorite);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section 5: Nearby Banner Card
            const SectionHeader(title: '5. Nearby / Popular Cars Banner Card'),
            const SizedBox(height: 12),
            CarBannerCard(
              car: mockNearbyCars.first,
              onTap: () {},
            ),
            const SizedBox(height: 24),

            // Section 6: Rating Badges
            const SectionHeader(title: '6. Rating Badges'),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 16,
              children: [
                RatingBadge(rating: 5.0, reviewsCount: 125),
                RatingBadge(rating: 4.9),
              ],
            ),
            const SizedBox(height: 24),

            // Section 7: Action Buttons
            const SectionHeader(title: '7. Action Buttons'),
            const SizedBox(height: 12),
            CustomElevatedButton(
              text: 'Book Now',
              backgroundColor: AppColors.primaryDark,
              foregroundColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(height: 12),
            CustomElevatedButton(
              text: 'Confirm Payment',
              backgroundColor: AppColors.primaryDark,
              foregroundColor: Colors.white,
              onTap: () {},
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) => setState(() => _selectedNavIndex = index),
      ),
    );
  }
}

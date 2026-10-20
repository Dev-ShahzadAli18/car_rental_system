import 'package:flutter/material.dart';
import '../../models/brand_model.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/brand_item_card.dart';
import '../../widgets/car_banner_card.dart';
import '../../widgets/car_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../car_details/car_details_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const HomeScreen({
    super.key,
    this.onSearchTap,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedBrand = 'tesla';
  List<CarModel> _cars = [];

  @override
  void initState() {
    super.initState();
    _cars = List.from(mockBestCars);
  }

  void _onCarTapped(CarModel car) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CarDetailsScreen(car: car),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Home App Bar
              CustomAppBar(
                type: AppBarType.home,
                notificationCount: 2,
                onNotificationTap: widget.onNotificationTap,
                onAvatarTap: widget.onProfileTap,
              ),
              const SizedBox(height: 16),

              // Search Row with Filter
              CustomSearchBar(
                readOnly: true,
                onTap: widget.onSearchTap,
                onFilterTap: widget.onSearchTap,
              ),
              const SizedBox(height: 24),

              // Brands Section Header
              Text(
                'Brands',
                style: AppTextStyles.title.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 14),

              // Brands List
              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: mockBrands.where((b) => b.id != 'all').length,
                  separatorBuilder: (_, _) => const SizedBox(width: 18),
                  itemBuilder: (context, index) {
                    final brand = mockBrands.where((b) => b.id != 'all').toList()[index];
                    return BrandItemCard(
                      brand: brand,
                      isSelected: _selectedBrand == brand.id,
                      onTap: () => setState(() => _selectedBrand = brand.id),
                      style: BrandCardStyle.circle,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Best Cars Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Cars',
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: widget.onSearchTap,
                    child: Text(
                      'View All',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Available',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 14),

              // Best Cars Horizontal List
              SizedBox(
                height: 240,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: _cars.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final car = _cars[index];
                    return CarCard(
                      car: car,
                      onTap: () => _onCarTapped(car),
                      onFavoriteToggle: () {
                        setState(() {
                          car.isFavorite = !car.isFavorite;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Nearby Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearby',
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: widget.onSearchTap,
                    child: Text(
                      'View All',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Nearby Horizontal Banner Card
              CarBannerCard(
                car: mockNearbyCars.first,
                onTap: () => _onCarTapped(mockNearbyCars.first),
              ),
              const SizedBox(height: 100), // padding for floating bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

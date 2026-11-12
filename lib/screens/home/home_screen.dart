import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../../models/brand_model.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/brand_item_card.dart';
import '../../widgets/car_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/section_header.dart';
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
  String _selectedBrand = 'all';
  List<CarModel> _cars = [];

  List<CarModel> get _filteredCars {
    if (_selectedBrand == 'all') return _cars;
    return _cars
        .where((c) => c.brand.toLowerCase() == _selectedBrand.toLowerCase())
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _cars = List.from(mockBestCars);
  }

  void _onCarTapped(CarModel car) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.home,
        onNotificationTap: widget.onNotificationTap,
        onAvatarTap: widget.onProfileTap,
      ),
      body: ResponsiveContentWrapper(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              CustomSearchBar(
                readOnly: true,
                onTap: widget.onSearchTap,
                onFilterTap: widget.onSearchTap,
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Brands'),
              const SizedBox(height: 14),
              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: mockBrands.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 25),
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
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Best Cars',
                subtitle: 'Available',
                actionText: 'View All',
                onActionTap: widget.onSearchTap,
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 250,
                child: _filteredCars.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No cars found for this brand',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        itemCount: _filteredCars.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final car = _filteredCars[index];
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
              SectionHeader(
                title: 'Nearby',
                actionText: 'View All',
                onActionTap: widget.onSearchTap,
              ),
              const SizedBox(height: 14),
              CarCard(
                height: 150,
                width: double.infinity,
                car: mockNearbyCars.first,
                style: CarCardStyle.banner,
                onTap: () => _onCarTapped(mockNearbyCars.first),
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

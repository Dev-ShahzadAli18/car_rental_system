import 'package:flutter/material.dart';
import '../../models/brand_model.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/brand_item_card.dart';
import '../../widgets/car_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../booking/booking_details_screen.dart';
import '../car_details/car_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const SearchScreen({
    super.key,
    this.onBackTap,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedBrandId = 'all';
  final TextEditingController _searchController = TextEditingController();
  List<CarModel> _allCars = [];
  List<CarModel> _filteredCars = [];

  @override
  void initState() {
    super.initState();
    _allCars = List.from(mockBestCars);
    _filteredCars = List.from(_allCars);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCars(String query) {
    setState(() {
      _filteredCars = _allCars.where((car) {
        final matchesQuery = car.name.toLowerCase().contains(query.toLowerCase()) ||
            car.brand.toLowerCase().contains(query.toLowerCase()) ||
            car.location.toLowerCase().contains(query.toLowerCase());
        final matchesBrand = _selectedBrandId == 'all' || car.brand.toLowerCase() == _selectedBrandId.toLowerCase();
        return matchesQuery && matchesBrand;
      }).toList();
    });
  }

  void _selectBrand(String brandId) {
    setState(() {
      _selectedBrandId = brandId;
    });
    _filterCars(_searchController.text);
  }

  void _onCarTapped(CarModel car) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CarDetailsScreen(car: car),
      ),
    );
  }

  void _onBookNowTapped(CarModel car) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BookingDetailsScreen(car: car),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Search',
        onBackTap: widget.onBackTap,
        onOptionsTap: () {},
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Search Input with Filter Button
            CustomSearchBar(
              controller: _searchController,
              onChanged: _filterCars,
              onFilterTap: () {
                _showFiltersBottomSheet(context);
              },
            ),
            const SizedBox(height: 18),

            // Horizontal Brand Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                children: mockBrands.map((brand) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BrandItemCard(
                      brand: brand,
                      isSelected: _selectedBrandId == brand.id,
                      onTap: () => _selectBrand(brand.id),
                      style: BrandCardStyle.pill,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Recommend For You Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommend For You',
                  style: AppTextStyles.title.copyWith(fontSize: 18),
                ),
                Text(
                  'View All',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 2x2 Grid of Car Cards
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredCars.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final car = _filteredCars[index];
                return CarCard(
                  car: car,
                  showBookNowButton: true,
                  onTap: () => _onCarTapped(car),
                  onBookNow: () => _onBookNowTapped(car),
                  onFavoriteToggle: () {
                    setState(() {
                      car.isFavorite = !car.isFavorite;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 24),

            // Our Popular Cars Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Our Popular Cars',
                  style: AppTextStyles.title.copyWith(fontSize: 18),
                ),
                Text(
                  'View All',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Popular Cars Horizontal List
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mockNearbyCars.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final car = mockNearbyCars[index];
                  return GestureDetector(
                    onTap: () => _onCarTapped(car),
                    child: Container(
                      width: 260,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder, width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              car.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(Icons.directions_car),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                car.name,
                                style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    car.rating.toStringAsFixed(1),
                                    style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 2),
                                  const Icon(Icons.star_rounded, size: 14, color: AppColors.starOrange),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '\$${car.pricePerDay.toInt()}/Day',
                                style: AppTextStyles.priceTag.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void _showFiltersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD3D6DC),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Filters',
                style: AppTextStyles.title.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Price Range',
                style: AppTextStyles.titleSmall.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 10),
              RangeSlider(
                values: const RangeValues(100, 400),
                min: 50,
                max: 600,
                activeColor: AppColors.primaryDark,
                inactiveColor: const Color(0xFFE4E7EC),
                onChanged: (val) {},
              ),
              const SizedBox(height: 16),
              Text(
                'Vehicle Type',
                style: AppTextStyles.titleSmall.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ['All', 'Sedan', 'SUV', 'Supercar', 'Electric'].map((type) {
                  final isSelected = type == 'All';
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryDark : const Color(0xFFF6F7F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      type,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Center(
                    child: Text(
                      'Apply Filter',
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

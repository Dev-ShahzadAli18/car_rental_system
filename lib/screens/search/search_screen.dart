import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../../models/brand_model.dart';
import '../../models/car_model.dart';
import '../../utils/app_colors.dart';
import '../../widgets/brand_item_card.dart';
import '../../widgets/car_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/section_header.dart';
import '../booking/booking_details_screen.dart';
import '../car_details/car_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const SearchScreen({super.key, this.onBackTap});

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
        final matchesQuery =
            car.name.toLowerCase().contains(query.toLowerCase()) ||
            car.brand.toLowerCase().contains(query.toLowerCase()) ||
            car.location.toLowerCase().contains(query.toLowerCase());
        final matchesBrand =
            _selectedBrandId == 'all' ||
            car.brand.toLowerCase() == _selectedBrandId.toLowerCase();
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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car)));
  }

  void _onBookNowTapped(CarModel car) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => BookingDetailsScreen(car: car)));
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
      body: ResponsiveContentWrapper(
        maxWidth: 800,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              CustomSearchBar(
                controller: _searchController,
                onChanged: _filterCars,
                onFilterTap: () => FilterBottomSheet.show(context),
              ),
              const SizedBox(height: 18),

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

              const SectionHeader(
                title: 'Recommend For You',
                actionText: 'View All',
              ),
              const SizedBox(height: 14),

              if (_filteredCars.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      'No cars found matching your search',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double availableWidth = constraints.maxWidth;
                    final int crossAxisCount = Responsive.gridColumns(
                      availableWidth,
                    );
                    final double itemWidth =
                        (availableWidth - (crossAxisCount - 1) * 14) /
                        crossAxisCount;
                    final double targetCardHeight =
                        availableWidth < Responsive.smallPhoneBreakpoint
                        ? 230.0
                        : 245.0;
                    final double aspectRatio = (itemWidth / targetCardHeight)
                        .clamp(0.55, 0.75);

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredCars.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: aspectRatio,
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
                    );
                  },
                ),

              const SectionHeader(
                title: 'Our Popular Cars',
                actionText: 'View All',
              ),
              const SizedBox(height: 14),

              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mockNearbyCars.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final car = mockNearbyCars[index];
                    return CarCard(
                      car: car,
                      style: CarCardStyle.compact,
                      onTap: () => _onCarTapped(car),
                    );
                  },
                ),
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

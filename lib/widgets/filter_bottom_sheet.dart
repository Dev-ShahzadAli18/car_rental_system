import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FilterBottomSheet extends StatefulWidget {
  final VoidCallback? onApply;

  const FilterBottomSheet({
    super.key,
    this.onApply,
  });

  static Future<void> show(BuildContext context, {VoidCallback? onApply}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(onApply: onApply),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(100, 400);
  String _selectedVehicleType = 'All';

  @override
  Widget build(BuildContext context) {
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
            values: _priceRange,
            min: 50,
            max: 600,
            activeColor: AppColors.primaryDark,
            inactiveColor: const Color(0xFFE4E7EC),
            onChanged: (val) => setState(() => _priceRange = val),
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
              final isSelected = _selectedVehicleType == type;
              return GestureDetector(
                onTap: () => setState(() => _selectedVehicleType = type),
                child: Container(
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
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.onApply?.call();
            },
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
  }
}

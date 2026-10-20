import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.bottomNavBackground,
          borderRadius: BorderRadius.circular(34),
          boxShadow: AppConstants.bottomNavShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
            _buildNavItem(index: 1, icon: Icons.search_rounded, label: 'Search'),
            _buildNavItem(index: 2, icon: Icons.mail_outline_rounded, label: 'Inbox'),
            _buildNavItem(index: 3, icon: Icons.notifications_none_rounded, label: 'Alerts'),
            _buildNavItem(index: 4, icon: Icons.person_outline_rounded, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? Colors.white : const Color(0xFF8E9398),
        ),
      ),
    );
  }
}

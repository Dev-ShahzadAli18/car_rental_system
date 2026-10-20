import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

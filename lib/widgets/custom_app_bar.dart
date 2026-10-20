import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

enum AppBarType {
  home,    
  inner,   
  simple,  
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final AppBarType type;
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onOptionsTap;
  final int notificationCount;
  final String? avatarUrl;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.type = AppBarType.inner,
    this.onBackTap,
    this.onNotificationTap,
    this.onAvatarTap,
    this.onOptionsTap,
    this.notificationCount = 2,
    this.avatarUrl,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: type == AppBarType.home ? _buildHomeAppBar(context) : _buildInnerAppBar(context),
      ),
    );
  }

  Widget _buildHomeAppBar(BuildContext context) {
    return Row(
      children: [
        
        Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: AppColors.primaryDark,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.directions_car_filled,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Qent',
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),

        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cardBorder, width: 1.2),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
              ),
              if (notificationCount > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        GestureDetector(
          onTap: onAvatarTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder, width: 1.2),
              image: DecorationImage(
                image: NetworkImage(
                  avatarUrl ??
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInnerAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        GestureDetector(
          onTap: onBackTap ?? () => Navigator.of(context).maybePop(),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder, width: 1.2),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        if (title != null)
          Text(
            title!,
            style: AppTextStyles.title.copyWith(fontSize: 18),
          ),

        if (actions != null && actions!.isNotEmpty)
          Row(children: actions!)
        else if (type == AppBarType.inner)
          GestureDetector(
            onTap: onOptionsTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cardBorder, width: 1.2),
              ),
              child: const Icon(
                Icons.more_horiz_rounded,
                size: 20,
                color: AppColors.textPrimary,
              ),
            ),
          )
        else
          const SizedBox(width: 44),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

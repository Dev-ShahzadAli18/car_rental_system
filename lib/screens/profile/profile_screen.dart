import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/profile_menu_tile.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationTap;

  const ProfileScreen({
    super.key,
    this.onBackTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Profile',
        onBackTap: onBackTap,
        onOptionsTap: () {},
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Row(
              children: [
                
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.cardBorder, width: 1.2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Benjamin  Jack',
                        style: AppTextStyles.title.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'benjaminJack@gmail.com',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    const Icon(Icons.edit_outlined, size: 18, color: AppColors.textSecondary),
                    const SizedBox(height: 2),
                    Text(
                      'Edit profile',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),

            Text(
              'General',
              style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            ProfileMenuTile(
              icon: Icons.favorite_border_rounded,
              title: 'Favorite Cars',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.history_rounded,
              title: 'Previous Rent',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notification',
              onTap: onNotificationTap ?? () {},
            ),
            ProfileMenuTile(
              icon: Icons.power_outlined,
              title: 'Connected to QENT Partnerships',
              onTap: () {},
            ),
            const SizedBox(height: 20),

            Text(
              'Support',
              style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            ProfileMenuTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.translate_rounded,
              title: 'Languages',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.person_add_alt_outlined,
              title: 'Invite Friends',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.shield_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.headset_mic_outlined,
              title: 'Help Support',
              onTap: () {},
            ),
            ProfileMenuTile(
              icon: Icons.logout_rounded,
              title: 'Log out',
              textColor: AppColors.red,
              iconColor: AppColors.red,
              onTap: () {},
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

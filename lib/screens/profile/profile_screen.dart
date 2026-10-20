import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';

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

            // Profile Info Header Card
            Row(
              children: [
                // Avatar with Camera Badge
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

                // Name & Email
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

                // Edit Profile Icon / Button
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

            // General Section
            Text(
              'General',
              style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildMenuItem(
              icon: Icons.favorite_border_rounded,
              title: 'Favorite Cars',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.history_rounded,
              title: 'Previous Rent',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.notifications_none_rounded,
              title: 'Notification',
              onTap: onNotificationTap ?? () {},
            ),
            _buildMenuItem(
              icon: Icons.power_outlined,
              title: 'Connected to QENT Partnerships',
              onTap: () {},
            ),
            const SizedBox(height: 20),

            // Support Section ("Saport" in Figma)
            Text(
              'Support',
              style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.translate_rounded,
              title: 'Languages',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.person_add_alt_outlined,
              title: 'Invite Friends',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.shield_outlined,
              title: 'Privacy Policy',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.headset_mic_outlined,
              title: 'Help Support',
              onTap: () {},
            ),
            _buildMenuItem(
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1.2),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? AppColors.textPrimary,
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.textPrimary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textSecondary,
          size: 20,
        ),
      ),
    );
  }
}

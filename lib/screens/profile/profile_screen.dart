import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/responsive.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/profile_menu_tile.dart';
import '../Auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationTap;

  const ProfileScreen({
    super.key,
    this.onBackTap,
    this.onNotificationTap,
  });

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthService.signOut();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final String displayName = user?.displayName != null && user!.displayName!.isNotEmpty
        ? user.displayName!
        : (user?.email != null && user!.email!.isNotEmpty
            ? user.email!.split('@').first
            : 'Benjamin Jack');
    final String displayEmail = user?.email ?? 'benjaminJack@gmail.com';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Profile',
        onBackTap: onBackTap,
        onOptionsTap: () {},
      ),
      body: ResponsiveContentWrapper(
        child: SingleChildScrollView(
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
                          displayName,
                          style: AppTextStyles.title.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displayEmail,
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
                onTap: () => _confirmLogout(context),
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

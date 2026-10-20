import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/notification_tile.dart';

class NotificationsScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const NotificationsScreen({
    super.key,
    this.onBackTap,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _showEmptyState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        type: AppBarType.inner,
        title: 'Notification',
        onBackTap: widget.onBackTap,
        onOptionsTap: () {
          setState(() => _showEmptyState = !_showEmptyState);
        },
      ),
      body: _showEmptyState ? _buildEmptyState() : _buildNotificationList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF1F4),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.notifications_paused_outlined,
                      size: 64,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.cardBorder, width: 1.2),
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'NO NOTIFICATIONS',
              style: AppTextStyles.title.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Clutter Cleared  We\'ll Notify You When There Is Something New.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => setState(() => _showEmptyState = false),
              child: const Text('Show Sample Notifications'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today',
                style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                '2 Unread Notification',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 14),

          const NotificationTile(
            icon: Icons.verified_outlined,
            title: 'Car Booking Successful',
            description: 'Your car is ready! Check your email for the booking and pickup instructions. Safe travels!',
            time: '10:00 am',
            isUnread: true,
          ),
          const NotificationTile(
            icon: Icons.receipt_long_outlined,
            title: 'Payment Notification',
            description: 'Your payment was processed successfully! Enjoy your ride.',
            time: '10:00 am',
            isUnread: true,
          ),
          const NotificationTile(
            icon: Icons.access_time_rounded,
            title: 'Car Pickup/Drop-off time',
            description: 'Pickup time confirmed! See you at 10:00 AM for your car rental. Drop-off Time Confirmed!',
            time: '09:00 am',
            isUnread: false,
          ),
          const SizedBox(height: 20),

          Text(
            'Previous',
            style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),

          const NotificationTile(
            icon: Icons.warning_amber_rounded,
            title: 'Late Return Warning',
            description: 'Late Return Alert! Please return the car as soon as possible to avoid extra charges.',
            time: 'Yesterday',
            isUnread: false,
          ),
          const NotificationTile(
            icon: Icons.cancel_outlined,
            title: 'Cancellation Notice',
            description: 'Your Reservation Has Been Canceled or Booking Cancelled Successfully.',
            time: 'Yesterday',
            isUnread: false,
          ),
          const NotificationTile(
            icon: Icons.discount_outlined,
            title: 'Discount Notification',
            description: 'Congratulations! You\'ve unlocked a 10% discount on your next rental.',
            time: 'Yesterday',
            isUnread: false,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'communication/inbox_screen.dart';
import 'home/home_screen.dart';
import 'notifications/notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'search/search_screen.dart';

class MainNavWrapper extends StatefulWidget {
  final int initialIndex;

  const MainNavWrapper({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        onSearchTap: () => _onTabChanged(1),
        onNotificationTap: () => _onTabChanged(3),
        onProfileTap: () => _onTabChanged(4),
      ),
      SearchScreen(
        onBackTap: () => _onTabChanged(0),
      ),
      InboxScreen(
        onBackTap: () => _onTabChanged(0),
      ),
      NotificationsScreen(
        onBackTap: () => _onTabChanged(0),
      ),
      ProfileScreen(
        onBackTap: () => _onTabChanged(0),
        onNotificationTap: () => _onTabChanged(3),
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}

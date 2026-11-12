import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:car_rental_system/screens/Auth/splash_screen.dart';
import 'package:car_rental_system/screens/Auth/boarding_screen.dart';
import 'package:car_rental_system/screens/Auth/login_screen.dart';
import 'package:car_rental_system/screens/main_nav_wrapper.dart';
import 'package:car_rental_system/widgets/custom_bottom_nav_bar.dart';
import 'package:car_rental_system/widgets/profile_menu_tile.dart';

void main() {
  testWidgets('SplashScreen renders branding and progresses to Onboarding',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    // Verify initial splash state
    expect(find.text('QENT'), findsOneWidget);
    expect(find.text('Drive Your Journey'), findsOneWidget);

    // Advance past the 2 second timer
    await tester.pump(const Duration(milliseconds: 2100));
    await tester.pumpAndSettle();

    // Verify it transitioned to OnboardingPage (when not logged in)
    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(find.text('SKIP'), findsOneWidget);
  });

  testWidgets('LoginPage renders cleanly with light unified theme',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);

    // Switch to Sign Up tab
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);
  });

  testWidgets('MainNavWrapper renders with CustomBottomNavBar at the bottom',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavWrapper(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify CustomBottomNavBar exists
    final navBarFinder = find.byType(CustomBottomNavBar);
    expect(navBarFinder, findsOneWidget);

    // Verify nav bar is positioned at the bottom of the screen
    final navBarRect = tester.getRect(navBarFinder);
    expect(navBarRect.bottom, equals(844.0));
    expect(navBarRect.height, lessThan(120.0)); // Height must be compact, NOT full-screen (844)

    // Verify Home tab header and sections are rendered
    expect(find.text('Qent'), findsOneWidget);
    expect(find.text('Brands'), findsOneWidget);
    expect(find.text('Best Cars'), findsOneWidget);

    // Tap on Search tab icon
    await tester.tap(find.byIcon(Icons.search_rounded));
    await tester.pumpAndSettle();

    // Verify Search tab is active
    expect(find.text('Recommend For You'), findsOneWidget);

    // Tap on Profile tab icon
    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();

    // Verify ProfileMenuTile items exist with no exceptions
    expect(find.byType(ProfileMenuTile), findsNWidgets(10));
    expect(find.text('Favorite Cars'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
  });
}

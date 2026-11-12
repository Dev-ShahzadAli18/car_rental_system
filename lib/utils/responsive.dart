import 'package:flutter/material.dart';

class Responsive {
  static const double smallPhoneBreakpoint = 360.0;
  static const double tabletBreakpoint = 600.0;
  static const double desktopBreakpoint = 1024.0;

  static const double maxContentWidth = 720.0;
  static const double maxFormWidth = 460.0;
  static const double maxBottomBarWidth = 520.0;
  static const double maxModalWidth = 520.0;

  static bool isSmallPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < smallPhoneBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint &&
      MediaQuery.sizeOf(context).width < desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  /// Returns responsive values based on current screen width.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? smallPhone,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTablet(context) && tablet != null) return tablet;
    if (isSmallPhone(context) && smallPhone != null) return smallPhone;
    return mobile;
  }

  /// Calculates responsive grid column count based on available container width.
  static int gridColumns(
    double width, {
    int phone = 2,
    int tablet = 3,
    int desktop = 4,
  }) {
    if (width >= desktopBreakpoint) return desktop;
    if (width >= tabletBreakpoint) return tablet;
    return phone;
  }
}

/// Reusable wrapper that centers content and constrains maximum width on tablets and desktop browsers.
class ResponsiveContentWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContentWrapper({
    super.key,
    required this.child,
    this.maxWidth = Responsive.maxContentWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }
    return content;
  }
}

/// Reusable floating bottom action bar that handles SafeArea and tablet/desktop max-width.
class ResponsiveBottomBar extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry margin;

  const ResponsiveBottomBar({
    super.key,
    required this.child,
    this.maxWidth = Responsive.maxBottomBarWidth,
    this.margin = const EdgeInsets.fromLTRB(20, 0, 20, 16),
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(padding: margin, child: child),
          ),
        ),
      ),
    );
  }
}

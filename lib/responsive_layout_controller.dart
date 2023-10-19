import 'package:flutter/material.dart';

class ResponsiveLayoutController extends StatelessWidget {
  const ResponsiveLayoutController({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  final Widget mobile;
  final Widget tablet;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 700;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 700 && constraints.maxHeight <= 900) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

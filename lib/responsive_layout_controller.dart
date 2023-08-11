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
      MediaQuery.of(context).size.width < 550;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600 && constraints.maxHeight >= 600) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

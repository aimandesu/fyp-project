import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/widgets/mobile_bottom_bar.dart';

import 'home/home.dart';

class MainLayoutController extends StatelessWidget {
  const MainLayoutController({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayoutController(
        mobile: SizedBox(
          width: size.width * 1,
          child: Stack(
            children: const [
              Home(),
              MobileBottomBar(),
            ],
          ),
        ),
        tablet: SizedBox(
          width: size.width * 1,
          child: Stack(
            children: const [
              Home(),
              MobileBottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

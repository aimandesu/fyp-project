import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/home/widgets/tab_views.dart';

import 'widgets/shelter_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // print(ResponsiveLayoutController.isMobile(context));
    // print(ResponsiveLayoutController.isTablet(context));

    return ResponsiveLayoutController(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width * 1,
              height: 200,
              child: const ShelterMap().animate().fadeIn(),
            ),
            // const Statistic(),
            const Expanded(
              child: TabViews(),
            ),
            // const Statistic(),
            // Container(
            //   margin: const EdgeInsets.all(10),
            //   child: const MapLocation(),
            // ),
          ],
        ),
        tablet: Row(
          children: [
            SizedBox(
              width: size.width * 0.4,
              height: 200,
              child: const ShelterMap().animate().fadeIn(),
            ),
            const Expanded(
              child: TabViews(),
            ),
          ],
        ));
  }
}

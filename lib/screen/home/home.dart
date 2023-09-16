import 'package:flutter/material.dart';
import 'package:fyp_project/screen/home/widgets/map_location.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/statistic_notUsedCurrently/statistic.dart';

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

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            SizedBox(
              width: size.width * 1,
              height: size.height * 0.25,
              child: const ShelterMap(),
            ),
            const Statistic(),
            Container(
              margin: const EdgeInsets.all(10),
              child: const MapLocation(),
            ),
          ],
        ),
        tablet: Container(
          margin: const EdgeInsets.all(10),
          child: const MapLocation(),
        ),
      ),
    );
  }
}

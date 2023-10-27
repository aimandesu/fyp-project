import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/home/widgets/tab_views.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/shelter_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> testApi() async {
    //https://api.data.gov.my/weather/forecast/?contains=Ipoh@location__location_name&date_start=2023-10-16@date&date_end=2023-10-18@date
    //https://api.data.gov.my/weather/forecast/?contains=Ipoh@location__location_name
    //https://api.data.gov.my/flood-warning/?contains=PERAK@state
    //https://api.data.gov.my/flood-warning/?contains=PERAK@state&contains=Kinta@district
    final response = await http.get(
      Uri.parse(
        "",
      ),
    );
    print(json.decode(response.body));
  }

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
            // TextButton(
            //   onPressed: testApi,
            //   child: const Text("Click me"),
            // )
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

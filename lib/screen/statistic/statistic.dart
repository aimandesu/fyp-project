import 'package:flutter/material.dart';
import 'package:fyp_project/screen/statistic/widgets/line_chart.dart';
import 'package:fyp_project/screen/statistic/widgets/circular_chart.dart';
import 'package:fyp_project/screen/statistic/widgets/funnel_chart.dart';
import 'package:fyp_project/screen/statistic/widgets/spline_chart.dart';

class Graph extends StatelessWidget {
  // static const routeName = 'graph';

  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // // appBar: AppBar(
        // //   title: const Text("Data for something"),
        // // ),
        // body:

        const SingleChildScrollView(
      //here we will pass the data using future builder, for each of the instance
      child: Column(
        children: [
          Text("Nothing here at the moments")
          // LineChart(),
          // CircularChart(),
          // FunnelChart(),
          // SplineChart(),
        ],
      ),
      // ),
    );
  }
}

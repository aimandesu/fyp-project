import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaucheChart extends StatefulWidget {
  const GaucheChart({super.key});

  @override
  State<GaucheChart> createState() => _GaucheChartState();
}

class _GaucheChartState extends State<GaucheChart> {
  List<dynamic>? waterLevel;
  List<SfRadialGauge> chartData = [];

  void currentWaterLevel() async {
    final response = await http.get(Uri.parse(
        "https://api.data.gov.my/flood-warning/?contains=PERAK@state&contains=Kinta@district"));
    waterLevel = json.decode(response.body);
    chartData = (waterLevel)!
        .where((data) =>
            data["water_level_normal_level"] != null &&
            data["water_level_alert_level"] != null &&
            data["water_level_warning_level"] != null &&
            data["water_level_danger_level"] != null)
        .map((data) {
      // return WaterLevelModel(
      //   place: data["station_name"],
      //   currentWaterLevel: data["water_level_current"],
      // );
      return SfRadialGauge(
        title: GaugeTitle(
          text: data["station_name"],
        ),
        enableLoadingAnimation: true, animationDuration: 4500,
        axes: [
          RadialAxis(
            showLabels: false,
            showAxisLine: false,
            showTicks: false,
            minimum: data["water_level_normal_level"] - 10,
            maximum: data["water_level_danger_level"],
            ranges: [
              GaugeRange(
                color: const Color(0xFFd1e4ff),
                label: "N",
                startValue: 0,
                endValue: data["water_level_normal_level"],
              ),
              GaugeRange(
                gradient: const SweepGradient(
                    colors: [Color(0xFFd1e4ff), Color(0xFF00497d)]),
                label: "A",
                labelStyle: const GaugeTextStyle(color: Colors.white),
                startValue: data["water_level_normal_level"],
                endValue: data["water_level_alert_level"],
              ),
              GaugeRange(
                gradient: const SweepGradient(colors: [
                  Color(0xFF00497d),
                  Color(0xFFc06c84),
                ]),
                label: "D",
                labelStyle: const GaugeTextStyle(color: Colors.white),
                startValue: data["water_level_alert_level"],
                endValue: data["water_level_danger_level"],
              ),
            ],
            pointers: [
              NeedlePointer(
                value: data["water_level_current"],
              )
            ],
            annotations: [
              GaugeAnnotation(
                  widget: Text(
                    data["water_level_current"].toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  angle: 90,
                  positionFactor: 0.5)
            ],
          )
        ],
        // barPointers: [LinearBarPointer(value: data["water_level_current"])],
      );
    }).toList();
  }

  @override
  void initState() {
    currentWaterLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            //   Wrap(
            //   direction: Axis.vertical,
            //   alignment: WrapAlignment.center,
            //   children: "Water Level".split("").map((string) => Text(string)).toList(),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Text("Ipoh Water Level", style: textStyling20),
                ),
                const Text("N - normal"),
                const Text("A - alert"),
                const Text("D - danger")
              ],
            ),
            ...chartData,
          ],
        ),
      ),
    );
  }
}

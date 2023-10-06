import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChart extends StatelessWidget {
  const CircularChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfCircularChart(
        title: ChartTitle(text: 'Sales by sales person'),
        legend: Legend(isVisible: true),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: <_PieData>[
                _PieData("Oily foods", 20, "20%"),
                _PieData("Carbonated Drinks", 30, "30%"),
                _PieData("Vegetables", 30, "30%")
              ],
              xValueMapper: (_PieData data, _) => data.xData,
              yValueMapper: (_PieData data, _) => data.yData,
              dataLabelMapper: (_PieData data, _) => data.text,
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
}

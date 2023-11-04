import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedBarChart extends StatelessWidget {
  const StackedBarChart({super.key});

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData("PPK", 35, 23, 45, 12),
      ChartData("Pgg", 31, 3, 15, 22),
      ChartData("faPK", 45, 7, 35, 12),
    ];

    return SfCartesianChart(
        title: ChartTitle(
          text: "Bantuan Daripada Organisasi",
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          StackedBarSeries<ChartData, String>(
              groupName: 'Group A',
              dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1
          ),
          StackedBarSeries<ChartData, String>(
              groupName: 'Group B',
              dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2
          ),
          StackedBarSeries<ChartData, String>(
              groupName: 'Group A',
              dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y3
          ),
          StackedBarSeries<ChartData, String>(
              groupName: 'Group B',
              dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true),
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y4
          )
        ]

    );
  }
}

class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChart extends StatelessWidget {
  const SplineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Average high/low temperature of Ipoh'),
      legend: const Legend(isVisible: true),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks),
      primaryYAxis: NumericAxis(
          minimum: 30,
          maximum: 80,
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          labelFormat: '{value}°F',
          majorTickLines: const MajorTickLines(size: 0)),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <SplineSeries<ChartSampleData, String>>[
        SplineSeries<ChartSampleData, String>(
          dataSource: [
            ChartSampleData('Jan', 43, 37, 41),
            ChartSampleData('Feb', 45, 37, 45),
            ChartSampleData('Mar', 50, 39, 48),
            ChartSampleData('Apr', 55, 43, 52),
            ChartSampleData('May', 63, 48, 57),
            ChartSampleData('Jun', 68, 54, 61),
            ChartSampleData('Jul', 72, 57, 66),
            ChartSampleData('Aug', 70, 57, 66),
            ChartSampleData('Sep', 66, 54, 63),
            ChartSampleData('Oct', 57, 48, 55),
            ChartSampleData('Nov', 50, 43, 50),
            ChartSampleData('Dec', 45, 37, 45)
          ],
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: true),
          name: 'High',
        ),
        SplineSeries<ChartSampleData, String>(
          dataSource: [
            ChartSampleData('Jan', 43, 37, 41),
            ChartSampleData('Feb', 45, 37, 45),
            ChartSampleData('Mar', 50, 39, 48),
            ChartSampleData('Apr', 55, 43, 52),
            ChartSampleData('May', 63, 48, 57),
            ChartSampleData('Jun', 68, 54, 61),
            ChartSampleData('Jul', 72, 57, 66),
            ChartSampleData('Aug', 70, 57, 66),
            ChartSampleData('Sep', 66, 54, 63),
            ChartSampleData('Oct', 57, 48, 55),
            ChartSampleData('Nov', 50, 43, 50),
            ChartSampleData('Dec', 45, 37, 45)
          ],
          name: 'Low',
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        )
      ],
    );
  }
}

class ChartSampleData {
  final String x;
  final int y;
  final int secondSeriesYValue;
  final int thirdSeriesYValue;

  ChartSampleData(
    this.x,
    this.y,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
  );
}

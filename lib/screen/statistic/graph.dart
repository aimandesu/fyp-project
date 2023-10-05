import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatelessWidget {
  static const routeName = 'graph';

  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data for something"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                    // Bind data source
                    dataSource: <SalesData>[
                      SalesData('Jan', 35),
                      SalesData('Feb', 28),
                      SalesData('Mar', 34),
                      SalesData('Apr', 32),
                      SalesData('May', 40)
                    ],
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales),
              ],
            ),
            Center(
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
            ),
            SfFunnelChart(
              title: ChartTitle(text: "Funnel Chart"),
              series: FunnelSeries(
                dataSource: [
                  {'stage': 'Awareness', 'value': 100},
                  {'stage': 'Interest', 'value': 75},
                  {'stage': 'Consideration', 'value': 50},
                  {'stage': 'Purchase', 'value': 25},
                ],
                xValueMapper: (dynamic data, _) => data['stage'],
                yValueMapper: (dynamic data, _) => data['value'],
                dataLabelSettings: DataLabelSettings(isVisible: true)
              ),
            ),
            SfCartesianChart(
                plotAreaBorderWidth: 0,
                title: ChartTitle(
                    text:'Average high/low temperature of London'),
                legend: Legend(isVisible: true),
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
              ]
            )
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
}

class Test {
  Test(this.testing);

  final int testing;
}

class ChartSampleData {
  final String x;
  final int y;
  final int secondSeriesYValue;
  final int thirdSeriesYValue;

  ChartSampleData(this.x, this.y, this.secondSeriesYValue, this.thirdSeriesYValue,);

}

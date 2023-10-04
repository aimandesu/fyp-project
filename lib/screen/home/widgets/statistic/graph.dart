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

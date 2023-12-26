import 'package:flutter/material.dart';
import 'package:fyp_project/models/charts/cases_count_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatelessWidget {
  const LineChart({
    super.key,
    required this.snapshot,
  });

  final List<dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    List<CasesCountModel> chartData = (snapshot).map((data) {
      return CasesCountModel(
        month: data['month'],
        numberCases: data['numberCases'],
      );
    }).toList();

    return SfCartesianChart(
      title: ChartTitle(
        text: "Occurrence Cases of Natural Hazard",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      primaryXAxis: CategoryAxis(),
      series: <LineSeries<CasesCountModel, String>>[
        LineSeries<CasesCountModel, String>(
          // Bind data source
          dataSource: chartData,
          xValueMapper: (CasesCountModel cases, _) => cases.month,
          yValueMapper: (CasesCountModel cases, _) => cases.numberCases,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp_project/models/charts/shelter_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/charts/cases_count_model.dart';

class ColumnChart extends StatelessWidget {
  const ColumnChart({super.key, required this.snapshot});

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
        text: "Bilangan Mangsa di Pusat Pemindahan",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries<CasesCountModel, String>>[
        // Renders column chart
        ColumnSeries<CasesCountModel, String>(
          dataSource: chartData,
          xValueMapper: (CasesCountModel data, _) => data.month,
          yValueMapper: (CasesCountModel data, _) => data.numberCases,
        )
      ],
    );
  }
}




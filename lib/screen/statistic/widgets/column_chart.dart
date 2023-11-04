import 'package:flutter/material.dart';
import 'package:fyp_project/models/charts/shelter_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatelessWidget {
  const ColumnChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ShelterModel> chartData = [
      ShelterModel(month: "Jan", counts: 10),
      ShelterModel(month: "Feb", counts: 5),
      ShelterModel(month: "Mac", counts: 30),
      ShelterModel(month: "April", counts: 3)
    ];
    return SfCartesianChart(
      title: ChartTitle(
        text: "Bilangan Mangsa di Pusat Pemindahan",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries<ShelterModel, String>>[
        // Renders column chart
        ColumnSeries<ShelterModel, String>(
          dataSource: chartData,
          xValueMapper: (ShelterModel data, _) => data.month,
          yValueMapper: (ShelterModel data, _) => data.counts,
        )
      ],
    );
  }
}

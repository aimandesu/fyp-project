import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FunnelChart extends StatelessWidget {
  const FunnelChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfFunnelChart(
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
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    );
  }
}

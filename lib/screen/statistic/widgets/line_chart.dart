import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/dataset_provider.dart';
import 'package:fyp_project/models/charts/cases_count_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  Future<dynamic>? lineChart;
  List<String> _years = [];
  String _selectedYear = DateTime.now().year.toString();

  void initialiseYear() async {
    _years = await DatasetProvider().fetchYear();
  }

  @override
  void initState() {
    lineChart = DatasetProvider().fetchLineChart(_selectedYear);
    initialiseYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 20),
        StatefulBuilder(
          builder: (context, change) {
            return DropdownButton(
              value: _selectedYear,
              items: _years.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                change(() {
                  _selectedYear = value.toString();
                });
                setState(() {
                  lineChart = DatasetProvider().fetchLineChart(_selectedYear);
                });
              },
              underline: Container(
                color: Colors.transparent,
              ),
            );
          },
        ),
        FutureBuilder<dynamic>(
          future: lineChart,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting for data.
            }

            List<CasesCountModel> chartData =
                (snapshot.data as List<dynamic>).map((data) {
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
                    yValueMapper: (CasesCountModel cases, _) =>
                        cases.numberCases,
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: true)),
              ],
            );
          },
        ),
      ],
    );
  }
}

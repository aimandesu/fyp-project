import 'package:flutter/material.dart';
import 'package:fyp_project/models/charts/race_percentage_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChart extends StatefulWidget {
  const CircularChart({super.key, required this.snapshot});

  final List<dynamic> snapshot;

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {

  final List<String> _months = [
    "Jan",
    "Feb",
    "Mac",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  Map? dataToShow;

  final DateTime _currentMonth = DateTime.now();
  String _selectedMonth = "";

  void setDataToShow(String selectedMonth) {
    Map<String, dynamic> element = widget.snapshot.firstWhere(
      (entry) => entry["month"] == selectedMonth,
      orElse: () => <String, dynamic>{},
    );

    if (element.isEmpty) {
      setState(() {
        dataToShow = null;
      });
    } else {
      setState(() {
        dataToShow = element;
      });
    }
  }

  void initializeCurrentMonth() {
    setState(() {
      _selectedMonth = DateFormat("MMMM").format(_currentMonth).substring(0, 3);
    });
  }

  @override
  void initState() {
    initializeCurrentMonth();
    setDataToShow(_selectedMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setDataToShow(_selectedMonth);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StatefulBuilder(
          builder: (context, change) {
            return DropdownButton(
              focusColor: Colors.transparent,
              dropdownColor: Theme.of(context).colorScheme.onPrimary,
              value: _selectedMonth,
              items: _months.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                change(() {
                  _selectedMonth = value.toString();
                });
                setDataToShow(_selectedMonth);
              },
              underline: Container(
                color: Colors.transparent,
              ),
            );
          },
        ),
        dataToShow == null
            ? Container()
            : SfCircularChart(
                title:  ChartTitle(
                  text: "Kes berdasarkan demografi",
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                legend: const Legend(isVisible: true),
                series: <PieSeries<RacePercentageModel, String>>[
                  PieSeries<RacePercentageModel, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: <RacePercentageModel>[
                      RacePercentageModel(
                        race: "Malay",
                        numberCases: dataToShow!["numberCases"],
                        raceCases: dataToShow!["race"]["malay"],
                      ),
                      RacePercentageModel(
                        race: "Chinese",
                        numberCases: dataToShow!["numberCases"],
                        raceCases: dataToShow!["race"]["chinese"],
                      ),
                      RacePercentageModel(
                        race: "Indian",
                        numberCases: dataToShow!["numberCases"],
                        raceCases: dataToShow!["race"]["indian"],
                      )
                    ],
                    xValueMapper: (RacePercentageModel data, _) => data.race,
                    yValueMapper: (RacePercentageModel data, _) =>
                        data.percentage(),
                    dataLabelMapper: (RacePercentageModel data, _) =>
                        "${data.percentage()}%",
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
      ],
    );
  }
}

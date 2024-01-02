import 'package:flutter/material.dart';
import 'package:fyp_project/models/charts/hazard_percentage_model.dart';
import 'package:fyp_project/models/charts/table_hazard_details.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularChart extends StatefulWidget {
  const CircularChart({
    super.key,
    required this.snapshot,
    required this.selectedYear,
  });

  final List<dynamic> snapshot;
  final String selectedYear;

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

  List<HazardPercentageModel> generateDataSource(
    Map<String, dynamic> dataToShow
  ) {
    List<HazardPercentageModel> dataSource = [];
    dataToShow['hazard'].forEach((hazard, value) {
      if (value != null && value > 0) {
        dataSource.add(
          HazardPercentageModel(
            hazard: hazard,
            numberCases: dataToShow["numberCases"],
            hazardCases: value,
          ),
        );
      }
    });
    return dataSource;
  }

  @override
  Widget build(BuildContext context) {
    setDataToShow(_selectedMonth);

    List<HazardPercentageModel> dynamicDataSource = dataToShow == null
        ? []
        : generateDataSource(dataToShow! as Map<String, dynamic>);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        dataToShow == null
            ? Container()
            : SfCircularChart(
                title: ChartTitle(
                  text: "Natural Hazard Cases Based on Demography",
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                legend: const Legend(isVisible: true),
                series: <PieSeries<HazardPercentageModel, String>>[
                  PieSeries<HazardPercentageModel, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: dynamicDataSource,
                    xValueMapper: (HazardPercentageModel data, _) =>
                        "${data.hazard} / ${data.hazardCases} cases",
                    yValueMapper: (HazardPercentageModel data, _) =>
                        data.percentage(),
                    dataLabelMapper: (HazardPercentageModel data, _) =>
                        "${data.percentage()}%",
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
        TableHazardDetails(
          selectedYear: widget.selectedYear,
          selectedMonth: _selectedMonth,
        ),
        const Spacer(),
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
      ],
    );
  }
}

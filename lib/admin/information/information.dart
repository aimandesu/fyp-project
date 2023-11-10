import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/statistic/widgets/column_chart.dart';

import '../../screen/statistic/widgets/circular_chart.dart';
import '../../screen/statistic/widgets/funnel_chart.dart';
import '../../screen/statistic/widgets/line_chart.dart';
import '../../screen/statistic/widgets/spline_chart.dart';
import '../../screen/statistic/widgets/stackedbar_chart.dart';
import '../providers/dataset_provider.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  Future<dynamic>? chart;
  List<String> _years = [];
  String _selectedYear = DateTime.now().year.toString();

  void initialiseYear() async {
    final List<String> yearsAvailable = await DatasetProvider().fetchYear();
    setState(() {
      _years = yearsAvailable;
    });
  }

  @override
  void initState() {
    chart = DatasetProvider().fetchChart(_selectedYear);
    initialiseYear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color color = Theme.of(context).colorScheme.onPrimary;
    double circular = 25;

    return FutureBuilder(
      future: chart,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(); // Show a loading indicator while waiting for data.
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatefulBuilder(
                builder: (context, change) {
                  return DropdownButton(
                    focusColor: Colors.transparent,
                    dropdownColor: Theme.of(context).colorScheme.onPrimary,
                    value: _selectedYear,
                    items: _years.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? value) {
                      change(() {
                        _selectedYear = value.toString();
                      });
                      setState(() {
                        chart = DatasetProvider().fetchChart(_selectedYear);
                      });
                    },
                    underline: Container(
                      color: Colors.transparent,
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.5,
                    margin: marginDefined,
                    decoration: decorationDefinedShadow(color, circular),
                    child: LineChart(
                      snapshot: snapshot.data,
                    ),
                  ),
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.5,
                    margin: marginDefined,
                    decoration: decorationDefinedShadow(color, circular),
                    child: CircularChart(
                      snapshot: snapshot.data,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size.height * 0.5,
                      margin: marginDefined,
                      decoration: decorationDefinedShadow(color, circular),
                      child: const StackedBarChart(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.5,
                    height: size.height * 0.4,
                    margin: marginDefined,
                    decoration: decorationDefinedShadow(color, circular),
                    child: const SplineChart(),
                  ),
                  Expanded(
                    child: Container(
                      margin: marginDefined,
                      decoration: decorationDefinedShadow(color, circular),
                      child: ColumnChart(
                        snapshot: snapshot.data,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/statistic/widgets/column_chart.dart';

import '../../screen/statistic/widgets/circular_chart.dart';
import '../../screen/statistic/widgets/funnel_chart.dart';
import '../../screen/statistic/widgets/line_chart.dart';
import '../../screen/statistic/widgets/spline_chart.dart';
import '../../screen/statistic/widgets/stackedbar_chart.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color color = Theme.of(context).colorScheme.onPrimary;
    double circular = 25;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: size.width * 0.3,
              height: size.height * 0.5,
              margin: marginDefined,
              decoration: decorationDefinedShadow(color, circular),
              child: const LineChart(),
            ),
            Container(
              width: size.width * 0.3,
              height: size.height * 0.5,
              margin: marginDefined,
              decoration: decorationDefinedShadow(color, circular),
              child: const CircularChart(),
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
                height: size.height * 0.4,
                margin: marginDefined,
                decoration: decorationDefinedShadow(color, circular),
                child: const ColumnChart(),
              ),
            ),
          ],
        )
      ],
    );
  }
}

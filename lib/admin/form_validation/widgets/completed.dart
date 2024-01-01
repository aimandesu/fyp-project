import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import '../../providers/form_provider.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  late Future<List<Map<String, dynamic>>> callsForm;

  @override
  void initState() {
    callsForm = FormProvider().pickForms(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tableCells = [
      "Name",
      "Gender",
      "No IC",
      "Phone No",
      "Address",
      "Sub District",
      "Postcode",
      "Category",
      "Action"
    ];

    final rowSpacer = TableRow(
      children: [
        ...List.generate(
          9,
          (_) => const SizedBox(height: 8),
        )
      ],
    );

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: callsForm,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Table(
            // columnWidths: const <int, TableColumnWidth>{
            //   0: IntrinsicColumnWidth(),
            //   1: FlexColumnWidth(),
            //   2: FixedColumnWidth(64),
            // },
            // border: TableBorder.symmetric(
            //   outside: const BorderSide(
            //     width: 1,
            //     color: Colors.black45,
            //   ),
            // ),
            children: <TableRow>[
              TableRow(
                children: [
                  ...tableCells.map((e) => TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ],
              ),
              ...snapshot.data!.fold(
                  [],
                  (arr, item) => [
                        ...arr,
                        TableRow(
                          decoration: decorationDefinedShadow(
                            Theme.of(context).colorScheme.onPrimary,
                            15,
                          ),
                          children: [
                            buildSizedBox(Text(item['name'])),
                            buildSizedBox(Text(item['gender'])),
                            buildSizedBox(Text(item['noIC'])),
                            buildSizedBox(Text(item['phone'])),
                            buildSizedBox(Text(item['address'])),
                            buildSizedBox(Text(item['subDistrict'])),
                            buildSizedBox(Text(item['postcode'])),
                            buildSizedBox(Text(item['category'])),
                            buildSizedBox(Text(item['actions']))
                          ],
                        ),
                        rowSpacer,
                      ]),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  SizedBox buildSizedBox(Widget textWidget) {
    return SizedBox(
      height: 60,
      child: Center(child: textWidget),
    );
  }
}

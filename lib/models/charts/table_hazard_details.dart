import 'package:flutter/material.dart';
import '../../admin/providers/dataset_provider.dart';

class TableHazardDetails extends StatefulWidget {
  const TableHazardDetails({
    super.key,
    required this.selectedYear,
    required this.selectedMonth,
  });

  final String selectedYear;
  final String selectedMonth;

  @override
  State<TableHazardDetails> createState() => _TableHazardDetailsState();
}

class _TableHazardDetailsState extends State<TableHazardDetails> {
  List<Map<String, dynamic>>? data;

  void setDataToShow(selectedYear, selectedMonth) async {
    final toFetch = await DatasetProvider()
        .fetchDisasterDetails(selectedYear, selectedMonth);
    setState(() {
      data = toFetch;
    });
  }

  @override
  void initState() {
    setDataToShow(widget.selectedYear, widget.selectedMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setDataToShow(widget.selectedYear, widget.selectedMonth);
    List<DataRow> rows = [];

    if (data != null) {
      for (var entry in data!) {
        rows.add(
          DataRow(cells: <DataCell>[
            DataCell(Text(entry['type'])),
            const DataCell(SizedBox()),
            const DataCell(SizedBox()),
          ]),
        );
        entry['place'].forEach((place) {
          rows.add(
            DataRow(cells: <DataCell>[
              const DataCell(SizedBox()),
              DataCell(Text(place['name'])),
              DataCell(Text(place['count'].toString())),
            ]),
          );
        });
      }
    }

    return data == null
        ? Container()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('Type'),
                ),
                DataColumn(
                  label: Text('Place'),
                ),
                DataColumn(
                  label: Text('Count'),
                ),
              ],
              rows: rows,
            ),
          );
  }
}

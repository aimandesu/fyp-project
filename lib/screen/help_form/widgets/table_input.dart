import 'package:flutter/material.dart';

class TableInput extends StatelessWidget {
  const TableInput({
    required this.listFamilies,
    super.key,
  });

  final List<Map<String, TextEditingController>> listFamilies;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: const [
              DataColumn(
                label: Text('Nama', style: TextStyle(fontSize: 18)),
              ),
              DataColumn(label: Text('Umur', style: TextStyle(fontSize: 18))),
              DataColumn(label: Text('No IC', style: TextStyle(fontSize: 18))),
              DataColumn(
                  label: Text('Hubungan', style: TextStyle(fontSize: 18))),
            ],
            rows: listFamilies.map<DataRow>((controllers) {
              return DataRow(cells: [
                DataCell(TextField(
                  controller:
                      controllers['name${listFamilies.indexOf(controllers)}'],
                  decoration: const InputDecoration(hintText: "nama"),
                )),
                DataCell(TextField(
                  controller:
                      controllers['age${listFamilies.indexOf(controllers)}'],
                  decoration: const InputDecoration(hintText: "umur"),
                  keyboardType: TextInputType.number,
                )),
                DataCell(TextField(
                  controller:
                      controllers['ICno${listFamilies.indexOf(controllers)}'],
                  decoration: const InputDecoration(hintText: "no ic"),
                  keyboardType: TextInputType.number,
                )),
                DataCell(TextField(
                  controller: controllers[
                      'relationship${listFamilies.indexOf(controllers)}'],
                  decoration: const InputDecoration(hintText: "hubungan"),
                )),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

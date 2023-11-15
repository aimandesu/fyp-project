import 'package:flutter/material.dart';

import '../../../constant.dart';

class ListReport extends StatelessWidget {
  const ListReport({
    super.key,
    required this.reportIncidence,
    required this.reportOn,
    required this.changeReportOn,
  });

  final Future<List<Map<String, dynamic>>> reportIncidence;
  final String? reportOn;
  final Function changeReportOn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 250,
      height: size.height * 0.8,
      decoration:
          decorationDefinedShadow(Theme.of(context).colorScheme.onPrimary, 35),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: marginDefined,
      child: FutureBuilder(
        future: reportIncidence,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String reportID = snapshot.data![index]["reportID"];
                return ListTile(
                  trailing: reportOn == reportID
                      ? const Icon(Icons.select_all_rounded)
                      : null,
                  title: const Text("reportID"),
                  subtitle: Text(reportID),
                  onTap: () {
                    changeReportOn(reportID, snapshot.data![index]);
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

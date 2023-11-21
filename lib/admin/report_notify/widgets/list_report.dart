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

    return FutureBuilder(
      future: reportIncidence,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Container(
            width: 250,
            height: size.height * 1,
            decoration: decorationDefinedShadow(
                Theme.of(context).colorScheme.onPrimary, 35),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            margin: marginDefined,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String reportID = snapshot.data![index]["reportID"];
                return ListTile(
                  trailing: reportOn == reportID
                      ? const Icon(Icons.select_all_rounded)
                      : null,
                  title: const Text("ID report"),
                  subtitle: Text(reportID),
                  onTap: () {
                    changeReportOn(reportID, snapshot.data![index]);
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/providers/support_result_provider.dart';
import 'package:fyp_project/screen/support_result/dart/widgets/result.dart';
import 'package:provider/provider.dart';

class SupportResult extends StatelessWidget {
  static const routeName = "/support-result";

  const SupportResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Senarai Kes Dipohon"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Provider.of<SupportResultProvider>(context, listen: false)
            .getAppliedForm(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Timestamp timestamp = snapshot.data![index]['date'];
                String caseID = snapshot.data![index]['caseID'];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Result.routeName, arguments: caseID);
                  },
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(
                      "${timestamp.toDate().day}, ${timestamp.toDate().month}, ${timestamp.toDate().year}"
                    ),
                    subtitle: Text(snapshot.data![index]['caseID']),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 10,
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

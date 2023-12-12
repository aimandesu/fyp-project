import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

class FormCounts extends StatelessWidget {
  const FormCounts({super.key, required this.formCounts});

  final Stream<dynamic>? formCounts;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: formCounts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> myList = snapshot.data;

            int pending = 0;
            int completed = 0;

            for (bool item in myList) {
              item == false ? pending++ : completed++;
            }

            return Row(
              children: [
                Container(
                    width: 150,
                    margin: marginDefined,
                    decoration: decorationDefinedShadow(
                        Theme.of(context).colorScheme.onPrimary, 25),
                    child: ListTile(
                      title: const Text("Pending"),
                      subtitle: Text(pending.toString()),
                      // trailing: Text("data"),
                    )),
                Container(
                  width: 150,
                  margin: marginDefined,
                  decoration: decorationDefinedShadow(
                      Theme.of(context).colorScheme.onPrimary, 25),
                  child: ListTile(
                    title: const Text("Completed"),
                    subtitle: Text(completed.toString()),
                    // trailing: Text("data"),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

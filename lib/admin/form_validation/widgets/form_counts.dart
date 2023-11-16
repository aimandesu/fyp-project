import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

class FormCounts extends StatelessWidget {
  const FormCounts({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: 150,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
          child: const ListTile(
            title: Text("Pending"),
            subtitle: Text("23"),
            // trailing: Text("data"),
          )
        ),
        Container(
          width: 150,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
          child: const ListTile(
            title: Text("OnWatch"),
            subtitle: Text("23"),
            // trailing: Text("data"),
          ),
        ),
        Container(
          width: 150,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
          child: const ListTile(
            title: Text("Completed"),
            subtitle: Text("23"),
            // trailing: Text("data"),
          ),
        )
      ],
    );
  }
}

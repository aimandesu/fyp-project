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
          height: 100,
          width: size.width * 0.1,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
          child: const ListTile(
            title: Text("title"),
            subtitle: Text("23"),
            trailing: Text("data"),
          )
        ),
        Container(
          height: 100,
          width: size.width * 0.1,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
        ),
        Container(
          height: 100,
          width: size.width * 0.1,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
        )
      ],
    );
  }
}

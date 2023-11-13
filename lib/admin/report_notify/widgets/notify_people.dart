import 'package:flutter/material.dart';

import '../../../constant.dart';

class NotifyPeople extends StatelessWidget {
  const NotifyPeople({
    super.key,
    required this.sendNotification,
    required this.title,
    required this.body,
  });

  final void Function(Map<String, dynamic>, String) sendNotification;
  final TextEditingController title;
  final TextEditingController body;

  @override
  Widget build(BuildContext context) {
    List<String> district = [
      "Ipoh",
      "Lahat",
      "Tanjung Rambutan",
      "Chemor",
    ];

    String currentDistrict = district.first;

    return Column(
      children: [
        //stateful builder for mukim ada
        StatefulBuilder(builder: (context, setState) {
          return DropdownButton(
            value: currentDistrict,
            items: district.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                currentDistrict = value.toString();
              });
            },
          );
        }),
        Container(
          width: 200,
          padding: paddingDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primaryContainer, 25),
          child: TextFormField(
            controller: title,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        Container(
          width: 200,
          padding: paddingDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primary, 25),
          child: TextFormField(
            controller: body,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            sendNotification(
              {
                "title": title.text,
                "body": body.text,
              },
              currentDistrict,
            );
          },
          child: const Text("Beri Amaran"),
        )
      ],
    );
  }
}

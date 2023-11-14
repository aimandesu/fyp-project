import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../constant.dart';

class NotifyPeople extends StatelessWidget {
  const NotifyPeople({
    super.key,
    required this.sendNotification,
    required this.title,
    required this.body,
  });

  final void Function(Map<String, dynamic>, String, List<String>)
      sendNotification;
  final TextEditingController title;
  final TextEditingController body;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String>? images = [];

    List<String> district = [
      "Ipoh",
      "Lahat",
      "Tanjung Rambutan",
      "Chemor",
    ];

    String currentDistrict = district.first;

    return Column(
      children: [
        const Text(
          "Beri Amaran",
          style: textStyling,
        ),
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
          width: size.width * 0.25,
          margin: marginDefined,
          padding: paddingDefined,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primaryContainer, 25),
          child: TextFormField(
            controller: title,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
            ),
          ),
        ),
        DragTarget<String>(
          onAccept: (value) {
            print("value acepted");

            images.add(value);
          },
          onLeave: (value) {
            print("value does not land"); //should we do something here?
          },
          builder: (context, _, reject) {
            return Container(
              height: size.height * 0.2,
              width: size.width * 0.25,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: decorationDefinedShadow(
                  Theme.of(context).colorScheme.primaryContainer, 25),
              child: Stack(
                children: [
                  images.isNotEmpty
                      ? ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          }),
                          child: PageView.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Image.network(images[index]);
                              }),
                        )
                      : const Center(
                          child: Text(
                              "No pictures selected, please drag the pictures"),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: paddingDefined,
                          margin: marginDefined,
                          decoration: decorationDefinedShadow(
                            Theme.of(context).colorScheme.onPrimary,
                            25,
                          ),
                          child: const Text("Drop Here"),
                        ),
                        Container(
                            padding: paddingDefined,
                            margin: marginDefined,
                            decoration: decorationDefinedShadow(
                              Theme.of(context).colorScheme.onPrimary,
                              25,
                            ),
                            child: Text(images.length.toString())),
                      ],
                    ),
                  )
                ],
              ),
            );

            // return images.isNotEmpty
            //     ? Text(images[0]!)
            //     : Container(
            //         height: 20,
            //         width: 20,
            //         color: Colors.blue,
            //       );
          },
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            // width: 200,
            padding: paddingDefined,
            decoration: decorationDefinedShadow(
                Theme.of(context).colorScheme.primaryContainer, 25),
            child: TextFormField(
              controller: body,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Description",
              ),
              maxLines: null,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: marginDefined,
            child: ElevatedButton(
              onPressed: () {
                sendNotification(
                  {
                    "title": title.text,
                    "body": body.text,
                  },
                  currentDistrict,
                  images,
                );
              },
              child: const Text("Beri Amaran"),
            ),
          ),
        )
      ],
    );
  }
}

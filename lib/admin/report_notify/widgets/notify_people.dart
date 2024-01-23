import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';

class NotifyPeople extends StatelessWidget {
  const NotifyPeople({
    super.key,
    required this.sendNotification,
    required this.title,
    required this.body,
    required this.images,
    required this.geoPoints,
    required this.district,
  });

  final void Function(Map<String, dynamic>, String, List<String>, List<GeoPoint>, DateTime,)
      sendNotification;
  final TextEditingController title;
  final TextEditingController body;
  final List<String>? images;
  final List<GeoPoint>? geoPoints;
  final List<String> district;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String currentDistrict = district.first;

    return Column(
      children: [
        const Text(
          "Alert",
          style: textStyling30,
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

            images?.add(value);
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
                  images!.isNotEmpty
                      ? ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          }),
                          child: PageView.builder(
                              itemCount: images?.length,
                              itemBuilder: (context, index) {
                                return Image.network(images![index]);
                              }),
                        )
                      : const Center(
                          child: Text("Drag the pictures here"),
                        ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: paddingDefined,
                      margin: marginDefined,
                      decoration: decorationDefinedShadow(
                        Theme.of(context).colorScheme.onPrimary,
                        25,
                      ),
                      child: Text(images!.length.toString()),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        DragTarget<GeoPoint>(
          onAccept: (value) {
            print("value acepted");

            geoPoints?.add(value);
          },
          onLeave: (value) {
            print("value does not land"); //should we do something here?
          },
          builder: (context, _, reject) {
            return Container(
              height: size.height * 0.1,
              width: size.width * 0.25,
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: decorationDefinedShadow(
                  Theme.of(context).colorScheme.primaryContainer, 25),
              child: geoPoints!.isNotEmpty
                  ? ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: PageView.builder(
                        itemCount: geoPoints?.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("latitude: ${geoPoints![index].latitude}"),
                              Text("longitude: ${geoPoints![index].longitude}"),
                            ],
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text("Drag location points here"),
                    ),
            );
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
                  images!,
                  geoPoints!,
                  DateTime.now() //here should have mcm option utk pick time
                );
              },
              child: const Text("Send Alert"),
            ),
          ),
        )
      ],
    );
  }
}

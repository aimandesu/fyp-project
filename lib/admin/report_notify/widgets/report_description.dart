import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../constant.dart';

class ReportDescription extends StatelessWidget {
  const ReportDescription({super.key, required this.formToRender});

  final Map<String, dynamic>? formToRender;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: formToRender == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/chat.json"),
                const Text(
                  "Helping people is a good deed. Have a nice day!",
                  style: textStyling,
                )
              ],
            )
          : Container(
              margin: marginDefined,
              decoration: decorationDefinedShadow(
                Theme.of(context).colorScheme.onPrimary,
                25,
              ),
              child: Column(
                children: [
                  Text(
                    formToRender!["disaster"].join(", "),
                    style: textStyling,
                  ),
                  ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      },
                    ),
                    child: Container(
                      margin: marginDefined,
                      height: size.height * 0.5,
                      decoration: decorationDefinedShadow(
                        Theme.of(context).colorScheme.primaryContainer,
                        25,
                      ),
                      child: PageView.builder(
                        itemCount: formToRender!["pictures"].length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Image.network(
                                formToRender!["pictures"][index],
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 10,
                                child: Container(
                                  padding: paddingDefined,
                                  margin: marginDefined,
                                  decoration: decorationDefinedShadow(
                                    Theme.of(context).colorScheme.onPrimary,
                                    25,
                                  ),
                                  child: Draggable<String>(
                                    data: formToRender!["pictures"][index],
                                    feedback: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: decorationDefined(
                                        Colors.blue,
                                        35,
                                      ),
                                    ),
                                    child: const Text("Drag"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: marginDefined,
                    decoration: decorationDefinedShadow(
                        Theme.of(context).colorScheme.primaryContainer, 25),
                    child: Column(
                      children: [
                        formToRender!["description"] != ""
                            ? Text(formToRender!["description"])
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "latitude: ${formToRender!["currentLocation"].latitude}"),
                            Text(
                                "longitude: ${formToRender!["currentLocation"].longitude}"),
                            Container(
                              padding: paddingDefined,
                              margin: marginDefined,
                              decoration: decorationDefinedShadow(
                                Theme.of(context).colorScheme.onPrimary,
                                25,
                              ),
                              child: Draggable<GeoPoint>(
                                data: formToRender!["currentLocation"],
                                feedback: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: decorationDefined(
                                    Colors.blue,
                                    35,
                                  ),
                                ),
                                child: const Text("Drag"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

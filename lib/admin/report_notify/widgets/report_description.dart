import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../constant.dart';
import 'package:http/http.dart' as http;

class ReportDescription extends StatelessWidget {
  const ReportDescription({super.key, required this.formToRender});

  final Map<String, dynamic>? formToRender;
  
  void showPlace(var lat, var long) async{
    final response = await http.get(
      Uri.parse("https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$long&apiKey=$reverseGeoApiKey")
    );
    final json = jsonDecode(response.body);
    print("called here geo reverse");
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime? date = formToRender == null ? null : (formToRender!["date"] as Timestamp).toDate();
    String? dateIncident = date == null ? null : DateFormat.yMMMMd('en_US').format(date);

    return Expanded(
      child: formToRender == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/chat.json"),
                const Text(
                  "Helping people is a good deed. Have a nice day!",
                  style: textStyling30,
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
                  OutlinedButton(onPressed: () => showPlace(
                      formToRender!["currentLocation"].latitude,
                      formToRender!["currentLocation"].longitude
                  ), child: Text("fe")),
                  Text(
                    formToRender!["disaster"].join(", "),
                    style: textStyling30,
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
                            fit: StackFit.passthrough,
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
                        Text(dateIncident!),
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

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../constant.dart';

class ReportDescription extends StatelessWidget {
  const ReportDescription({
    super.key,
    required this.formToRender,
    required this.address,
  });

  final Map<String, dynamic>? formToRender;
  final String address;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    DateTime? date = formToRender == null
        ? null
        : (formToRender!["date"] as Timestamp).toDate();
    String? dateIncident = date == null
        ? null
        : "${DateFormat.yMMMMd('en_US').format(date)} / ${date.hour}:${date.minute}";

    return Expanded(
      child: formToRender == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/chat.json"),
                const Text(
                  "None selected",
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
                              Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: Image.network(
                                  formToRender!["pictures"][index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
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
                  Expanded(
                    child: Container(
                      margin: marginDefined,
                      padding: paddingDefined,
                      decoration: decorationDefinedShadow(
                          Theme.of(context).colorScheme.primaryContainer, 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildRowSpaceBetween(
                            const Text("Address"),
                            Text(address),
                          ),
                          buildRowSpaceBetween(
                            const Text("Date / Time"),
                            Text(dateIncident!),
                          ),
                          formToRender!["description"] != ""
                              ? buildRowSpaceBetween(
                                  const Text("Description"),
                                  Text(formToRender!["description"]),
                                )
                              : Container(),
                          buildRowSpaceBetween(
                            const Text("Latitude / Longitude"),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        "${formToRender!["currentLocation"].latitude}, "),
                                    Text(
                                      formToRender!["currentLocation"]
                                          .longitude
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 5,),
                                Container(
                                  padding: paddingDefined,
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
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Row buildRowSpaceBetween(
    Widget text,
    Widget display,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [text, display],
    );
  }
}

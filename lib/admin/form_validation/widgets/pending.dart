import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../constant.dart';
import '../../providers/form_provider.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  late Future<List<Map<String, dynamic>>> callsForm;
  String? formOn;
  Map<String, dynamic>? formToRender;
  String? pdf;
  bool showPDF = false;
  bool showAction = false;
  final TextEditingController commentController =
      TextEditingController(text: "");

  List<String> actions = actionsList;
  String actionsTodo = actionsList.first;

  @override
  void initState() {
    callsForm = FormProvider().pickForms(false);
    super.initState();
  }

  void updateHasComplete() {
    setState(() {
      callsForm = FormProvider().pickForms(false);
      formToRender = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        FutureBuilder(
          future: callsForm,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                width: 250,
                height: size.height * 0.8,
                decoration: decorationDefinedShadow(
                    Theme.of(context).colorScheme.onPrimary, 35),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                margin: marginDefined,
                child: Column(
                  children: [
                    const Text("Case form"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String caseID = snapshot.data![index]["caseID"];
                          return ListTile(
                            trailing: formOn == caseID
                                ? const Icon(Icons.select_all_rounded)
                                : null,
                            title: Text(caseID),
                            onTap: () {
                              setState(() {
                                showPDF = false;
                                formOn = caseID;
                                formToRender = snapshot.data![index];
                                pdf = formToRender!["selectedPDF"];
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        Expanded(
          child: formToRender == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400,
                      child: Lottie.asset("assets/form.json", repeat: false),
                    ),
                    const Text(
                      "Pick any form from the pending list.",
                      style: textStyling30,
                    )
                  ],
                )
              : showPDF
                  ? pdf == null && showPDF == false
                      ? Container()
                      : Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      showPDF = false;
                                    });
                                  },
                                  child: const Text("Close pdf"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: size.width * 0.7,
                              height: size.height * 0.7,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: decorationDefined(
                                Theme.of(context).colorScheme.primaryContainer,
                                26,
                              ),
                              padding: const EdgeInsets.all(20),
                              child: SfPdfViewer.network(
                                pdf.toString(),
                              ),
                            ),
                          ],
                        )
                  : Container(
                      width: size.width * 0.6,
                      height: size.height * 0.8,
                      margin: marginDefined,
                      decoration: decorationDefinedShadow(
                        Theme.of(context).colorScheme.onPrimary,
                        25,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Victim assistance form",
                            style: textStyling30,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width * 0.4,
                                  margin: marginDefined,
                                  decoration: decorationDefinedShadow(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    25,
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(dragDevices: {
                                      PointerDeviceKind.touch,
                                      PointerDeviceKind.mouse,
                                    }),
                                    child: PageView.builder(
                                      itemCount:
                                          (formToRender!["pictures"] as List)
                                              .length,
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          formToRender!["pictures"][index],
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
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
                                      Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      25,
                                    ),
                                    child: !showAction
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              buildRowSpaceBetween(
                                                const Text("Date"),
                                                Text(
                                                  DateFormat.yMMMMd('en_US')
                                                      .format(DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                              formToRender![
                                                                      "date"]
                                                                  .microsecondsSinceEpoch))
                                                      .toString(),
                                                ),
                                              ),
                                              buildRowSpaceBetween(
                                                const Text("Name"),
                                                Text(formToRender!["name"]),
                                              ),
                                              buildRowSpaceBetween(
                                                const Text("IC No"),
                                                Text(formToRender!["noIC"]),
                                              ),
                                              buildRowSpaceBetween(
                                                const Text("Category"),
                                                Text(formToRender!["category"]),
                                              ),
                                              buildRowSpaceBetween(
                                                const Text("Phone"),
                                                Text(formToRender!["phone"]),
                                              ),
                                              buildRowSpaceBetween(
                                                const Text("Address"),
                                                Text(
                                                  "${formToRender!['address']} ${formToRender!['postcode']} ${formToRender!['subDistrict']}",
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showPDF = true;
                                                      });
                                                    },
                                                    child: const Text(
                                                        "Supporting Document"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showAction = true;
                                                      });
                                                    },
                                                    child: const Text(
                                                        "Verify"), //then ni tukar tindakan kita apa
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showAction = false;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.arrow_back),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration:
                                                        decorationDefinedShadow(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      25,
                                                    ),
                                                    child:
                                                        const Text("Tindakan"),
                                                  ),
                                                  StatefulBuilder(builder:
                                                      (context, setState) {
                                                    return DropdownButton(
                                                      value: actionsTodo,
                                                      items:
                                                          actions.map((value) {
                                                        return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          actionsTodo =
                                                              value.toString();
                                                        });
                                                      },
                                                    );
                                                  }),
                                                  Container(
                                                    width: 300,
                                                    height: 300,
                                                    padding: paddingDefined,
                                                    decoration:
                                                        decorationDefinedShadow(
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            25),
                                                    child: TextFormField(
                                                      controller:
                                                          commentController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Description",
                                                      ),
                                                      maxLines: null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    FormProvider()
                                                        .updateHelpForm(
                                                      formOn!,
                                                      actionsTodo,
                                                      commentController.text,
                                                    );
                                                    updateHasComplete();
                                                  },
                                                  child: const Text("Done"))
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ],
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

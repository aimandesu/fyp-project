import 'dart:ui';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    callsForm = FormProvider().pickForms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: 250,
          height: size.height * 0.8,
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 35),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: marginDefined,
          child: FutureBuilder(
            future: callsForm,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String caseID = snapshot.data![index]["caseID"];
                    return ListTile(
                      trailing: formOn == caseID
                          ? const Icon(Icons.select_all_rounded)
                          : null,
                      title: const Text("caseID"),
                      subtitle: Text(caseID),
                      onTap: () {
                        setState(() {
                          showPDF = false;
                          formOn = snapshot.data![index]["caseID"].toString();
                          formToRender = snapshot.data![index];
                          pdf = formToRender!["selectedPDF"];
                        });
                      },
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Expanded(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse,
                                }),
                                child: PageView.builder(
                                  itemCount: (formToRender!["pictures"] as List)
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      formToRender!["pictures"][index],
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
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
                          ),
                          Container(
                            width: 300,
                            height: size.height * 0.5,
                            margin: marginDefined,
                            padding: paddingDefined,
                            decoration: decorationDefinedShadow(
                              Theme.of(context).colorScheme.onPrimary,
                              25,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(formToRender!["name"]),
                                Text(formToRender!["noIC"]),
                                Text(formToRender!["category"]),
                                Text(formToRender!["phone"]),
                                Text(
                                  "${formToRender!['address']} ${formToRender!['postcode']} ${formToRender!['district']}",
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showPDF = true;
                                        });
                                      },
                                      child: const Text("show pdf"),
                                    ),
                                    const ElevatedButton(
                                      onPressed: null,
                                      child: Text("Next"),
                                    )
                                  ],
                                )
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
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/form_provider.dart';
import 'package:lottie/lottie.dart';
import '../../constant.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  late Future<List<Map<String, dynamic>>> callsForm;
  String? formOn;
  Map<String, dynamic>? formToRender;

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
          height: size.height * 1,
          // decoration: decorationDefined(
          //     Theme.of(context).colorScheme.primaryContainer, 35),
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
                      tileColor: formOn == caseID
                          ? Colors.red
                          : Theme.of(context).colorScheme.onPrimary,
                      title: const Text("caseID"),
                      subtitle: Text(caseID),
                      onTap: () {
                        setState(() {
                          formOn = snapshot.data![index]["caseID"].toString();
                          formToRender = snapshot.data![index];
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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 350,
                      height: size.height * 0.7,
                      color: Colors.red,
                      child: Column(
                        children: [
                          Text(formToRender!["name"]),
                          Text(formToRender!["noIC"]),
                          Text(formToRender!["category"]),
                          Text(formToRender!["phone"]),
                          Text(
                            "${formToRender!['adress']} ${formToRender!['postcode']} ${formToRender!['district']}",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: size.height * 0.7,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        }),
                        child: PageView.builder(
                          itemCount: (formToRender!["pictures"] as List).length,
                          itemBuilder: (context, index) {
                            print((formToRender!["pictures"] as List).length);
                            print(formToRender!["pictures"][0]);
                            return Image.network(
                              formToRender!["pictures"][index],
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: size.height * 0.7,
                      child: Text("pdf"),
                    )
                  ],
                ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constant.dart';

class IdentificationInfo extends StatelessWidget {
  const IdentificationInfo({super.key, required this.identificationInfo});

  final Map<String, dynamic>? identificationInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return identificationInfo == null
        ? Container()
        : Container(
            height: size.height * 0.7,
            margin: marginDefined,
            decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primaryContainer,
              35,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(identificationInfo!["name"]),
                Text(identificationInfo!["identificationNo"]),
                Text(
                  identificationInfo!["communityAt"]["place"] +
                      identificationInfo!["communityAt"]["postcode"] +
                      identificationInfo!["communityAt"]["subDistrict"] +
                      identificationInfo!["communityAt"]["district"],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Verified"),
                )
              ],
            ),
          );
  }
}

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
            padding: paddingDefined,
            margin: marginDefined,
            decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primaryContainer,
              35,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildRowSpaceBetween(
                  const Text("Name"),
                  Text(identificationInfo!["name"]),
                ),
                buildRowSpaceBetween(
                  const Text("Identification No"),
                  Text(identificationInfo!["identificationNo"]),
                ),
                buildRowSpaceBetween(
                  const Text("address"),
                  Text(identificationInfo!["communityAt"]["place"]),
                ),
                buildRowSpaceBetween(
                  const Text("Postcode"),
                  Text(identificationInfo!["communityAt"]["postcode"]),
                ),
                buildRowSpaceBetween(
                  const Text("Sub District"),
                  Text(identificationInfo!["communityAt"]["subDistrict"]),
                ),
                buildRowSpaceBetween(
                  const Text("District"),
                  Text(identificationInfo!["communityAt"]["district"]),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Verified"),
                )
              ],
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

import 'package:flutter/material.dart';

import '../../../constant.dart';

class FrontBackIC extends StatelessWidget {
  const FrontBackIC({super.key, required this.identificationImage});

  final Map<String, dynamic>? identificationImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return identificationImage == null
        ? Container()
        : Container(
            height: size.height * 0.7,
            width: size.width * 0.3,
            margin: marginDefined,
            decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.primaryContainer,
              35,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildIcPreview(size, identificationImage!["front"]),
                  buildIcPreview(size, identificationImage!["back"]),
                ],
              ),
            ),
          );
  }

  SizedBox buildIcPreview(Size size, String position) {
    return SizedBox(
      height: size.height * 0.3,
      width: size.width * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25), // Image border
        child: SizedBox.fromSize(
          size: const Size.fromRadius(48), // Image radius
          child: Image.network(position, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

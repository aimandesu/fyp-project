import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/constant.dart';

class NameIdentification extends StatelessWidget {
  const NameIdentification({
    required this.name,
    required this.identificationNo,
    // required this.communityAt,
    super.key,
  });

  final String name;
  final String identificationNo;

  // final Map<String, dynamic> communityAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: decorationDefined(
        Theme.of(context).colorScheme.primaryContainer,
        25,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Nama"),
              Text(
                name,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Kad Pengenalan"),
              Text(
                identificationNo,
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(curve: Curves.easeIn);
  }
}

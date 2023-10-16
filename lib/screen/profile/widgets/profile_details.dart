import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constant.dart';
import '../../../responsive_layout_controller.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    required this.communityAt,
    super.key,
  });

  final Map<String, dynamic> communityAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          decorationDefined(Theme.of(context).colorScheme.primaryContainer, 25),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Alamat"),
              Text(
                communityAt['place'],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Mukim"),
              Text(communityAt['subDistrict']),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Poskod"),
              Text(communityAt['postcode']),
            ],
          )
        ],
      ),
    ).animate().fade(curve: Curves.easeIn);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../responsive_layout_controller.dart';

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
    final isTablet = ResponsiveLayoutController.isTablet(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius:
            isTablet ? BorderRadius.circular(0) : BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child:
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.add,
          //     ),
          Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           "Nama: $name",
            style: const TextStyle(),
          ),
          Text(
            // communityAt['place'],
            "No Kad Pengenalan: $identificationNo",
            style: const TextStyle(),
          ),
        ],
      ),
      //   ],
      // ),
    ).animate().fade(curve: Curves.easeIn);
  }
}

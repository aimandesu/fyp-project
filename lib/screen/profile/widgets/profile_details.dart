import 'package:flutter/material.dart';

import '../../../responsive_layout_controller.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            isTablet ? BorderRadius.circular(0) : BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("first"),
              Text("second"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("first"),
              Text("second"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("first"),
              Text("second"),
            ],
          )
        ],
      ),
    );
  }
}

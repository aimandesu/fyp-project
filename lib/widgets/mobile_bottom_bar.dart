import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

import '../profile/profile.dart';

class MobileBottomBar extends StatelessWidget {
  const MobileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final checkIfMobile = ResponsiveLayoutController.isMobile(context);

    return Positioned(
      bottom: 0,
      left: checkIfMobile ? 15 : 200,
      right: checkIfMobile ? 15 : 200,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_book_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.data_array_rounded),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Profile.routeName);
              },
              icon: const Icon(Icons.people_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

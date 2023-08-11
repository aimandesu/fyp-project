import 'package:flutter/material.dart';
import 'package:fyp_project/profile/widgets/name_title.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

import 'widgets/ic_profile.dart';
import 'widgets/profile_details.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            SizedBox(
              width: size.width * 1,
              height: size.height * 0.35,
              child: const IcProfile(),
            ),
            Container(
              width: size.width * 1,
              height: size.height * 0.08,
              margin: const EdgeInsets.all(15),
              child: const NameAndTitle(),
            ),
            Container(
              width: size.width * 1,
              height: size.height * 0.2,
              margin: const EdgeInsets.all(15),
              child: const ProfileDetails(),
            ),
          ],
        ),
        tablet: Column(
          children: [
            SizedBox(
              height: 250,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: const IcProfile(),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          // width: size.width * 1,
                          height: 125,
                          // margin: EdgeInsets.all(15),
                          child: NameAndTitle(),
                        ),
                        SizedBox(
                          // width: size.width * 1,
                          height: 125,
                          // margin: EdgeInsets.all(15),
                          child: ProfileDetails(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

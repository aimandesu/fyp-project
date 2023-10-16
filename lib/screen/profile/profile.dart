import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/profile/widgets/name_identification.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/verification/verification.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/profile_provider.dart';
import 'widgets/ic_profile.dart';
import 'widgets/profile_details.dart';

class Profile extends StatelessWidget {
  static const routeName = "/profile";

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    here I want to be able first to check if user has put their ic card 
    or whatever like that, if none yet do like the user can't sign in
    help form won't be submitted
     */

    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: Provider.of<ProfileProvider>(context, listen: false)
          .fetchOwnProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.hasData) {
            //ic profile
            final image = snapshot.data!['identificationImage'];
            final communityAt = snapshot.data!['communityAt'];
            final name = snapshot.data!['name'];
            final identificationNo = snapshot.data!['identificationNo'];

            //here buat update profile guna widget sama update profile using concep yg push navigation?
            //amik snapshot.data

            final data = snapshot.data;

            if (identificationNo == "") {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Lottie.asset(
                      "assets/map.json",
                      repeat: false,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Verification.routeName,
                        arguments: data,
                      );
                    }, //send snapshot.data
                    child: const Text("Update Profile"),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              );
            } else {
              return ResponsiveLayoutController(
                //ganti future builder
                mobile: Column(
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(
                    //         Verification.routeName,
                    //         arguments: data);
                    //   },
                    //   icon: const Icon(Icons.abc),
                    // ),
                    SizedBox(
                      width: size.width * 1,
                      height: size.height * 0.35,
                      child: IcProfile(
                        image: image,
                      ), //here terima gmbr je
                    ),
                    Container(
                      width: size.width * 1,
                      height: size.height * 0.08,
                      margin: marginDefined,
                      child: NameIdentification(
                        name: name, identificationNo: identificationNo,
                        // communityAt: communityAt,
                      ), //here terima name and title
                    ),
                    Container(
                      width: size.width * 1,
                      height: size.height * 0.2,
                      margin: marginDefined,
                      child: ProfileDetails(
                        communityAt: communityAt,
                      ), //here terima profile details
                    ),
                  ],
                ),
                tablet: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: IcProfile(
                        image: image,
                      ),
                    ),
                    Expanded(
                      // width: size.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: size.width * 1,
                            height: size.height * 0.4,
                            // margin: EdgeInsets.all(15),
                            child: NameIdentification(
                              name: name,
                              identificationNo: identificationNo,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 1,
                            height: size.height * 0.4,
                            // margin: EdgeInsets.all(15),
                            child: ProfileDetails(
                              communityAt: communityAt,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return const Text("Something is wrong");
          }
        }
      },
      // ),
    );
  }
}

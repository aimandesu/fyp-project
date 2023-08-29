import 'package:flutter/material.dart';
import 'package:fyp_project/screen/profile/widgets/name_title.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
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

    return SingleChildScrollView(
      child: FutureBuilder(
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

                //here buat update profile guna widget sama update profile

                return ResponsiveLayoutController(
                  //ganti future builder
                  mobile: Column(
                    children: [
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
                        margin: const EdgeInsets.all(15),
                        child: NameAndTitle(
                          name: name,
                          communityAt: communityAt,
                        ), //here terima name and title
                      ),
                      Container(
                        width: size.width * 1,
                        height: size.height * 0.2,
                        margin: const EdgeInsets.all(15),
                        child:
                            const ProfileDetails(), //here terima profile details
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
                              child: IcProfile(
                                image: image,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    // width: size.width * 1,
                                    height: 125,
                                    // margin: EdgeInsets.all(15),
                                    child: NameAndTitle(
                                      name: name,
                                      communityAt: communityAt,
                                    ),
                                  ),
                                  const SizedBox(
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
                );
              } else {
                return const Text("no data"); //here buat tmpt nak isi data tu.
              }
            }
          }),
    );
  }
}

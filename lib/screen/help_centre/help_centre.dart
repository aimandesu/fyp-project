import 'package:flutter/material.dart';
import 'package:fyp_project/screen/help_centre/widgets/donation_list.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location_new.dart';

import '../../constant.dart';

class HelpCentre extends StatefulWidget {
  static const routeName = "/help-centre";

  const HelpCentre({super.key});

  @override
  State<HelpCentre> createState() => _HelpCentreState();
}

class _HelpCentreState extends State<HelpCentre> {
  bool backTo = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mediaQuery = MediaQuery.of(context);

    AppBar appBar2 = AppBar(
      title: const Text("Pusat Bantuan"),
    );

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          backTo = true;
        });
        return true;
      },
      child: Scaffold(
        appBar: appBar2,
        body: Container(
          margin: marginDefined,
          height: (mediaQuery.size.height - paddingTop) * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              !backTo
                  ? SizedBox(
                      height: (mediaQuery.size.height - paddingTop) * 0.6,
                      child: const MapLocation(),
                    )
                  : Container(),
              Container(
                height: (mediaQuery.size.height - paddingTop) * 0.3,
                width: size.width * 1,
                decoration: decorationDefined(
                  Theme.of(context).colorScheme.primaryContainer,
                  25,
                ),
                child: const DonationList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/help_centre/widgets/donation_list.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location.dart';

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
        body: ResponsiveLayoutController(
          mobile: Container(
            margin: marginDefined,
            height: (mediaQuery.size.height - paddingTop) * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !backTo
                    ? SizedBox(
                        height: (mediaQuery.size.height - paddingTop) * 0.9,
                        child: const MapLocation(),
                      )
                    : Container(),
                // Container(
                //   height: (mediaQuery.size.height - paddingTop) * 0.3,
                //   width: size.width * 1,
                //   decoration: decorationDefined(
                //     Theme.of(context).colorScheme.primaryContainer,
                //     25,
                //   ),
                //   child: const DonationList(),
                // )
              ],
            ),
          ),
          tablet: Container(
            margin: marginDefined,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !backTo
                    ? SizedBox(
                        height: (mediaQuery.size.height - paddingTop) * 1,
                        width: size.width * 0.9,
                        child: const MapLocation(),
                      )
                    : Container(),
                // Expanded(
                //   child: Container(
                //     height: (mediaQuery.size.height - paddingTop) * 1,
                //     decoration: decorationDefined(
                //       Theme.of(context).colorScheme.primaryContainer,
                //       25,
                //     ),
                //     child: const DonationList(),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

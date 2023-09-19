import 'package:flutter/material.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location_new.dart';

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

    return WillPopScope(
      onWillPop: () async{
        setState(() {
          backTo = true;
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Pusat Bantuan"),),
        body:  Column(
          children: [
           !backTo ? const MapLocation() : Container(),
          ],
        ),
      ),
    );
  }
}

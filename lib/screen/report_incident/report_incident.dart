import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/report_incident/widgets/picture_display.dart';

import '../help_form/widgets/camera/picture_upload.dart';

class ReportIncidence extends StatefulWidget {
  static const routeName = "./report-incidence";

  const ReportIncidence({super.key});

  @override
  State<ReportIncidence> createState() => _ReportIncidenceState();
}

class _ReportIncidenceState extends State<ReportIncidence> {
  List<File>? pictures = [];

  Future<void> navigatePictureUpload(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      PictureUpload.routeName,
      arguments: {"pictures": pictures},
    );
    if (!mounted) return;
    setState(() {
      pictures = result as List<File>?;
    });
  }

  void _removePicture(int index) {
    setState(() {
      pictures = pictures!..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text("Kecelakaan"),
    );

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double paddingTop = appBar.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: ResponsiveLayoutController(
        mobile: Column(
          children: [
            const Text(
                "chip widget flutter - choose natural hazard incident happen"),
            Container(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 0.3,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Stack(
                children: [
                  pictures == null
                      ? Container()
                      : PictureDisplay(
                          picturesIncident: pictures,
                          removePicture: _removePicture,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: IconButton.filledTonal(
                      onPressed: () => navigatePictureUpload(context),
                      icon: const Icon(Icons.camera),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        tablet: const Text("tablet"),
      ),
    );
  }
}

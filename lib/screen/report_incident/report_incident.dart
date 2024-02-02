import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/data/chips_data.dart';
import 'package:fyp_project/models/report_incidence_model.dart';
import 'package:fyp_project/providers/report_provider.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/screen/report_incident/widgets/chip_choices.dart';
import 'package:fyp_project/screen/report_incident/widgets/picture_display.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' as lt;
import '../../constant.dart';
import '../help_form/widgets/camera/picture_upload.dart';
import '../help_form/widgets/textfield_decoration.dart';

class ReportIncidence extends StatefulWidget {
  static const routeName = "./report-incidence";

  const ReportIncidence({super.key});

  @override
  State<ReportIncidence> createState() => _ReportIncidenceState();
}

class _ReportIncidenceState extends State<ReportIncidence> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  List<File>? pictures = [];
  List<String> disaster = [];
  bool incidenceExtra = false;
  LocationData? currentLocation;
  final Set<Marker> _markers = <Marker>{};
  CameraPosition? _currentPlex;
  final incidentController = TextEditingController();
  bool backTo = false;

  void submitReport() {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    if (incidentController.text == "" ||
        currentLocation == null ||
        disaster == [] ||
        pictures == null) {
      popSnackBar(context, "Ada informasi tidak lengkap");
      return;
    }

    final reportIncidenceModel = ReportIncidenceModel(
      pictures: pictures as List<File>,
      currentLocation: GeoPoint(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ),
      disaster: disaster,
      description: incidentController.text,
      userUID: userUID,
    );

    ReportProvider.submitIncident(
      reportIncidenceModel,
      context,
    ).whenComplete(() {
      Navigator.pop(context);
      popSnackBar(context, "Laporan dihantar.");
    }).onError(
      (error, stackTrace) => popSnackBar(context, error.toString()),
    );
    popLoadingDialog(context);
  }

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

  void resetSelectionState() {
    setState(() {
      backTo = true;
    });
    for (var chip in chipsData) {
      chip.selected = false;
    }
  }

  void changeIncidentExtra(bool toChange) {
    setState(() {
      incidenceExtra = toChange;
    });
  }

  void getCurrentLocation() async {
    if (mounted) {
      Location location = Location();

      location.getLocation().then((location) {
        setState(() {
          currentLocation = location;
          setPosition();
        });
      });
    }
  }

  void setCurrentPlex(LatLng point) {
    _currentPlex = CameraPosition(
      target: point,
      zoom: 14,
    );
  }

  void setYourPosMarker(LatLng point) {
    setState(() {
      String markerId = "your_location";

      _markers.add(
        Marker(
          markerId: MarkerId('marker$markerId'),
          // infoWindow: const InfoWindow(title: "From Json Marker"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: point,
        ),
      );
    });
  }

  void setPosition() {
    if (currentLocation != null) {
      setCurrentPlex(LatLng(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ));
      setYourPosMarker(LatLng(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ));
    }
  }

  @override
  void dispose() {
    incidentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text("Kecelakaan"),
    );

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double paddingTop = appBar.preferredSize.height + mediaQuery.padding.top;

    Widget buildTextField = incidenceExtra
        ? Expanded(
            child: Container(
              margin: marginDefined,
              padding: paddingDefined,
              decoration: inputDecorationDefined(context),
              child: TextField(
                controller: incidentController,
                maxLines: null,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: InputBorder.none, // Remove the underline
                ),
              ),
            ).animate().fade(duration: 300.ms),
          )
        : Container();

    return WillPopScope(
      onWillPop: () async {
        resetSelectionState();
        return true;
      },
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: mediaQuery.size.width * 1,
            height: (mediaQuery.size.height - paddingTop) * 1,
            child: ResponsiveLayoutController(
              mobile: Column(
                children: [
                  PictureDisplay(
                    picturesIncident: pictures,
                    removePicture: _removePicture,
                    navigatePictureUpload: navigatePictureUpload,
                    width: mediaQuery.size.width * 1,
                    height: (mediaQuery.size.height - paddingTop) * 0.3,
                  ),
                  buildMap(mediaQuery, paddingTop),
                  ChipChoices(
                    disaster: disaster,
                    incidentController: incidentController,
                    changeIncidentExtra: changeIncidentExtra,
                  ),
                  buildTextField,
                  incidenceExtra ? Container() : const Spacer(),
                  buildSubmitButton()
                ],
              ),
              tablet: const Text("tablet"),
            ),
          ),
        ),
      ),
    );
  }

  Align buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: marginDefined,
        child: FilledButton.tonal(
          onPressed: () => submitReport(),
          child: const Text("Hantar"),
        ),
      ),
    );
  }

  Container buildMap(MediaQueryData mediaQuery, double paddingTop) {
    return Container(
      margin: marginDefined,
      height: (mediaQuery.size.height - paddingTop) * 0.2,
      width: mediaQuery.size.width * 1,
      child: currentLocation == null
          ? Container(
              child: lt.Lottie.asset("assets/chat.json"),
            )
          : !backTo
              ? GoogleMap(
                  mapType: MapType.normal,
                  markers: _markers,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _currentPlex as CameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                )
              : Container(),
    );
  }
}

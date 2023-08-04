import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/statistic/statistic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// const LatLng currentLocation = LatLng(25.1193, 55.3773);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  void getCurrentLocation() async {
    // Location location = Location();

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // currentLocation = await location.getLocation();
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });

      print(currentLocation!.longitude!);
      print(currentLocation!.latitude!);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        37.42796133580664, -122.085749655962), //dapatkn location kita kt sini
    zoom: 14.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: "Google Plex"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  static final Marker _kLakeMarker = Marker(
    markerId: const MarkerId('_kLakeMarker'),
    infoWindow: const InfoWindow(title: "Lake Plex"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(37.43296265331129, -122.08832357078792),
  );

  static final Marker _tescoMarker = Marker(
    markerId: const MarkerId('_tescoMarker'),
    infoWindow: const InfoWindow(title: "Tesco"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(4.54450697799394, 101.06818938022208),
  );

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  static const Polyline _kPolyLine = Polyline(
    polylineId: PolylineId("_kPolyLine"),
    points: [
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.42796133580664, -122.085749655962)
    ],
    width: 5,
  );

  static const Polygon _kPolygon = Polygon(
    polygonId: PolygonId("_kPolygon"),
    points: [
      LatLng(37.43296265331129, -122.08832357078792),
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.418, -122.092),
      LatLng(37.435, -122.092),
    ],
    strokeWidth: 5,
    fillColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    CameraPosition? _currentPlex;

    if (currentLocation != null) {
      _currentPlex = CameraPosition(
        target: //LatLng(37.43296265331129, -122.0883235707872),
            LatLng(
          currentLocation!.latitude!,
          currentLocation!.longitude!,
        ),
        zoom: 14.4746,
      );
    }

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            SizedBox(
              width: size.width * 1,
              height: size.height * 0.25,
              child: const ShelterMap(),
            ),
            Statistic(),
            currentLocation == null
                ? const Text("loading")
                : Container(
                    height: size.height * 0.7,
                    width: size.width * 1,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      markers: {
                        // _kGooglePlexMarker,
                        _tescoMarker
                        // _kLakeMarker,
                      },
                      // polylines: {
                      //   _kPolyLine,
                      // },
                      // polygons: {
                      //   _kPolygon,
                      // },
                      initialCameraPosition: _currentPlex as CameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),

                    // const GoogleMap(
                    //   initialCameraPosition: CameraPosition(
                    //     target: currentLocation,
                    //     zoom: 14,
                    //   ),
                    // ),
                  ),

            // IconButton(
            //   onPressed: _goToTheLake,
            //   icon: const Icon(Icons.directions_boat),
            // )
          ],
        ),
        tablet: Text("tablet"),
      ),
    );
  }
}

class ShelterMap extends StatelessWidget {
  const ShelterMap({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.warning),
                SizedBox(
                  width: size.width * 0.7,
                  child: ListTile(
                    title: Text(
                      "Shelter",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "Please come for shelter",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: size.width * 1,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: const Text("data"),
            ),
          )
        ],
      ),
    );
  }
}

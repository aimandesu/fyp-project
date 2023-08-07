import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
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

  CameraPosition? _currentPlex;
  // Marker? _currentMarker;

  final Set<Marker> _markers = <Marker>{};

  void setCurrentPlex(LatLng point) {
    _currentPlex = CameraPosition(
      target: point,
      zoom: 14,
    );
  }

  var markerId = 0;

  void setMarker(LatLng point) {
    setState(() {
      // _markers.clear();
      markerId++;
      _markers.add(
        Marker(
          markerId: MarkerId('marker$markerId'),
          // infoWindow: const InfoWindow(title: "From Json Marker"),
          // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: point,
        ),
      );
    });
  }

  Future<void> goToPlace(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: point,
        zoom: 14,
      ),
    ));
    setMarker(point);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (currentLocation != null) {
      setCurrentPlex(LatLng(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ));
      setMarker(LatLng(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ));
    }

    // Widget displayCard(
    //   PlacesModel data,
    // ) {
    //   return ListTile(
    //     onTap: () {
    //       // print(data.location);
    //       goToPlace(
    //         LatLng(
    //           data.location.first['latitude'],
    //           data.location.first['longitude'],
    //         ),
    //       );
    //     },
    //     title: Text(
    //       data.location.first['name'].toString(),
    //     ),
    //   );
    // }

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            SizedBox(
              width: size.width * 1,
              height: size.height * 0.25,
              child: const ShelterMap(),
            ),
            const Statistic(),
            currentLocation == null
                ? const Text("loading")
                : SizedBox(
                    height: size.height * 0.7,
                    width: size.width * 1,
                    child: GoogleMap(
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer()),
                      },
                      mapType: MapType.normal,
                      markers: _markers,
                      initialCameraPosition: _currentPlex as CameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),

            // IconButton(
            //   onPressed: _goToTheLake,
            //   icon: const Icon(Icons.directions_boat),
            // )
            // SizedBox(
            //   height: 200,
            //   child: StreamBuilder<List<Map<String, dynamic>>>(
            //       stream:
            //           Provider.of<Maps>(context).listPlaces("Kinta", "Ipoh"),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         } else {
            //           if (snapshot.hasData) {
            //             return Container(
            //               child: ListView.builder(
            //                   itemCount: snapshot.data!.length,
            //                   itemBuilder: (context, index) {
            //                     print(snapshot.data);
            //                     print(snapshot.data!.length);
            //                     return displayCard(
            //                         PlacesModel.fromJson(snapshot.data![index])
            //                         // index,
            //                         );
            //                   }),
            //             );
            //           } else {
            //             print("snapshot data");
            //             print(snapshot.data);
            //             return const Text("no data");
            //           }
            //         }
            //       }),
            // ),
            IconButton(
              onPressed: () => goToPlace(
                const LatLng(4.544346551396297, 101.06816792254945),
              ),
              icon: const Icon(
                Icons.change_circle,
              ),
            )
          ],
        ),
        tablet: const Text("tablet"),
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

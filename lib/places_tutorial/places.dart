import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fyp_project/location_service.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};

  List<LatLng> polygonLatLngs = <LatLng>[];
  // List<PointLatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  Future<void> _goToPlace(
    // Map<String, dynamic> place,
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );
    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsNe['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));
    _setMarker(LatLng(lat, lng));
  }

  @override
  void initState() {
    _setMarker(const LatLng(4.597582544822808, 101.07344786441814));
    super.initState();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('marker'),
        position: point,
      ));
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;
    _polygons.add(
      Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: polygonLatLngs,
        strokeWidth: 2,
        fillColor: Colors.transparent,
      ),
    );
  }

  void _setPolyLine(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(
                point.latitude,
                point.longitude,
              ),
            )
            .toList(),
      ),
    );
  }

  //example marker and camera position

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.597582544822808, 101.07344786441814),
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

  //polyline and polygon

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

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _originController,
                        onChanged: (value) {},
                      ),
                      TextFormField(
                        controller: _destinationController,
                        onChanged: (value) {},
                      ),
                      // TextFormField(
                      //   controller: _searchController,
                      //   onChanged: (value) {},
                      // ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    // var place = await LocationService().getPlace(
                    //   _searchController.text,
                    // );
                    // _goToPlace(place);
                    var directions = await LocationService().getDirections(
                      _originController.text,
                      _destinationController.text,
                    );
                    _goToPlace(
                      directions['start_location']['lat'],
                      directions['end_location']['lng'],
                      directions['bounds_ne'],
                      directions['bounds_sw'],
                    );
                    _setPolyLine(directions['polyline_decoded']);
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.7,
              width: size.width * 1,
              child: GoogleMap(
                mapType: MapType.normal,
                // markers: {
                //   _kGooglePlexMarker,
                // },
                // polylines: {
                //   _kPolyLine,
                // },
                // polygons: {
                //   _kPolygon,
                // },
                markers: _markers,
                polygons: _polygons,
                polylines: _polylines,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onTap: (point) {
                  setState(() {
                    polygonLatLngs.add(point);
                    _setPolygon();
                  });
                },
              ),
            ),
          ],
        ),
        tablet: const Center(
          child: Text("tablet mode"),
        ),
      ),
    );
  }
}

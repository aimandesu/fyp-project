import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constant.dart';

class NewsMap extends StatefulWidget {
  const NewsMap({super.key, required this.geoPoints});

  final List<dynamic> geoPoints;

  @override
  State<NewsMap> createState() => _NewsMapState();
}

class _NewsMapState extends State<NewsMap> {
  final List<LatLng> latLng = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  late LatLng centerPoint;

  bool _isInit = true;

  void addMarkerPoints() {
    latLng.forEachIndexed((index, element) {
      _markers.add(
        Marker(
          markerId: MarkerId(index.toString()),
          position: element,
        ),
      );
    });
  }

  void addPolygonsPoints() {
    _polygons.add(
      Polygon(
        polygonId: const PolygonId("polyPoints"),
        points: latLng,
        strokeWidth: 1,
        fillColor: Colors.transparent,
      ),
    );
  }

  LatLng getCenterPoint() {
    double maxX = -180;
    double maxY = -90;
    double minX = 180;
    double minY = 90;

    for (LatLng point in latLng) {
      if (point.latitude > maxY) maxY = point.latitude;
      if (point.latitude < minY) minY = point.latitude;
      if (point.longitude > maxX) maxX = point.longitude;
      if (point.longitude < minX) minX = point.longitude;
    }

    return LatLng((maxY + minY) / 2, (maxX + minX) / 2);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        for (GeoPoint i in widget.geoPoints) {
          latLng.add(LatLng(i.latitude, i.longitude));
        }
        addMarkerPoints();
        addPolygonsPoints();
        centerPoint = getCenterPoint();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.3,
      width: size.width * 1,
      margin: marginDefined,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: centerPoint,
          zoom: 15,
        ),
        mapType: MapType.normal,
        markers: _markers,
        polygons: _polygons,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

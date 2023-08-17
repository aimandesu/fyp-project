import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fyp_project/constant.dart';
import 'dart:async';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({super.key});

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;
  // LatLng? destinationLocation;

  CameraPosition? _currentPlex;
  final Set<Marker> _markers = <Marker>{};
  int markerId = 0;
  List<String> _district = [];
  List<String> _subDistrict = [];
  String _currentDistrict = "";
  String _currentSubDistrict = "";

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints(LatLng destinationLocation) async {
    // print(destinationLocation.latitude);
    // print(destinationLocation.longitude);
    polylineCoordinates = [];
    print("polyline called");
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(currentLocation!.latitude as double,
          currentLocation!.longitude as double),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      print("result is not empty");
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    //somehow error
    // GoogleMapController googleMapController = await _controller.future;

    // location.onLocationChanged.listen((newLoc) {
    //   currentLocation = newLoc;
    //   googleMapController.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(
    //         zoom: 13.5,
    //         target: LatLng(newLoc.latitude!, newLoc.longitude!),
    //       ),
    //     ),
    //   );
    //   setState(() {});
    // });
  }

  void setMarker(List<Map<String, dynamic>> point) {
    setState(() {
      // _markers.clear();
      _markers.clear();
      markerId = 0;
      for (var point in point) {
        markerId++;
        _markers.add(
          Marker(
            markerId: MarkerId('marker$markerId'),
            // infoWindow: const InfoWindow(title: "From Json Marker"),
            // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: LatLng(point['latitude'], point['longitude']),
          ),
        );
      }
    });
  }

  void setYourPosMarker(LatLng point) {
    setState(() {
      // _markers.clear();
      // _markers.clear();
      String markerId = "your_location";
      // for (var point in point) {
      //   markerId++;
      _markers.add(
        Marker(
          markerId: MarkerId('marker$markerId'),
          // infoWindow: const InfoWindow(title: "From Json Marker"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: point,
        ),
      );
      // }
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
    // setMarker(point);
    // destinationLocation = ;
    // print(point.latitude);
    // print(point.longitude);
    getPolyPoints(LatLng(point.latitude, point.longitude));
  }

  void setCurrentPlex(LatLng point) {
    _currentPlex = CameraPosition(
      target: point,
      zoom: 14,
    );
  }

  void goToLocation(String currentSubDistrict) async {
    List<Map<String, dynamic>> points =
        await Provider.of<MapsProvider>(context, listen: false)
            .listMarkersSubDistrict(
      _currentDistrict,
      currentSubDistrict,
    );

    goToPlace(LatLng(points.first['latitude'], points.first['longitude']));
    // getPolyPoints();
    //sini
  }

  void initializeSubDistrict(String currentSubDistrict) async {
    List<Map<String, dynamic>> points =
        await Provider.of<MapsProvider>(context, listen: false)
            .listMarkersSubDistrict(
      _currentDistrict,
      currentSubDistrict,
    );
    setMarker(points);
    goToPlace(LatLng(points.first['latitude'], points.first['longitude']));
    // setCurrentPlex(LatLng(
    //     points.first['latitude'],
    //     points.first[
    //         'longitude'])); //this one should find nearest place, not first point of the subdistrict
  }

  void listSubDistrict(String currentDistrict) async {
    // print(_currentDistrict);
    _subDistrict = await Provider.of<MapsProvider>(context, listen: false)
        .listSubDistrict(currentDistrict);
    setState(() {
      _currentSubDistrict = _subDistrict.first;
      initializeSubDistrict(_currentSubDistrict);
    });
  }

  void initialSubDistrict(currentDistrict) async {
    _subDistrict = await Provider.of<MapsProvider>(context, listen: false)
        .listSubDistrict(currentDistrict);
    _currentSubDistrict = _subDistrict.first;
    initializeSubDistrict(_currentSubDistrict);
  }

  void listDistrict() async {
    _district =
        await Provider.of<MapsProvider>(context, listen: false).listDistrict();
    _currentDistrict = _district.first;
    initialSubDistrict(_currentDistrict);
  }

  @override
  void initState() {
    getCurrentLocation();
    listDistrict();
    // listSubDistrict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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

    return SizedBox(
      height: size.height * 0.6,
      child: Column(
        children: [
          Row(
            children: [
              StatefulBuilder(
                builder: (context, change) {
                  return DropdownButton(
                    value: _currentDistrict,
                    items: _district.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      change(() {
                        _currentDistrict = value.toString();
                        listSubDistrict(_currentDistrict);

                        // _subDistrict = ["Karai"];
                        // _currentSubDistrict = "Karai";
                      });
                      // setState(() {

                      // });
                      // setState(() {});
                      // setState(() {
                      //   // _subDistrict = [];
                      //   // _subDistrict = ["Karai"];
                      //   _currentSubDistrict = "Karai";
                      // });
                    },
                  );
                },
              ),
              StatefulBuilder(
                builder: (context, change) {
                  return DropdownButton(
                    value: _currentSubDistrict,
                    items: _subDistrict.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      change(() {
                        _currentSubDistrict = value.toString();
                      });
                      // print("curk:$_currentSubDistrict");
                      setState(() {
                        goToLocation(_currentSubDistrict);
                      });
                    },
                  );
                },
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () {
              //     setState(() {});
              //   },
              //   icon: const Icon(Icons.search),
              // ),
            ],
          ),
          SizedBox(
            height: size.height * 0.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.6,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: currentLocation == null
                      ? Container()
                      : GoogleMap(
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
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylineCoordinates,
                              color: Colors.blue,
                              width: 6,
                            )
                          },
                        ),
                ),
                Expanded(
                  child: StreamBuilder<dynamic>(
                    stream: Provider.of<MapsProvider>(context)
                        .listPlaces(_currentDistrict, _currentSubDistrict),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: size.height * 0.2,
                                child: ListView.builder(
                                    itemCount: snapshot.data![index].length,
                                    itemBuilder: (context, i) {
                                      return ListTile(
                                        title: Text(
                                          snapshot.data![index][i]['name'],
                                        ),
                                        onTap: () => goToPlace(
                                          LatLng(
                                            snapshot.data![index][i]
                                                ['latitude'],
                                            snapshot.data![index][i]
                                                ['longitude'],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            },
                          );
                        } else {
                          return const Text("no data");
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

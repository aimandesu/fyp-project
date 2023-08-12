import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:fyp_project/statistic/statistic.dart';
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
  CameraPosition? _currentPlex;
  final Set<Marker> _markers = <Marker>{};
  int markerId = 0;
  List<String> _district = [];
  List<String> _subDistrict = [];
  String _currentDistrict = "";
  String _currentSubDistrict = "";

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
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

  Future<void> goToPlace(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: point,
        zoom: 14,
      ),
    ));
    // setMarker(point);
  }

  void setCurrentPlex(LatLng point) {
    _currentPlex = CameraPosition(
      target: point,
      zoom: 14,
    );
  }

  void k(String currentSubDistrict) async {
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
      k(_currentSubDistrict);
    });
  }

  void initialSubDistrict(currentDistrict) async {
    _subDistrict = await Provider.of<MapsProvider>(context, listen: false)
        .listSubDistrict(currentDistrict);
    _currentSubDistrict = _subDistrict.first;
    k(_currentSubDistrict);
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
      // setMarker(LatLng(
      //   currentLocation!.latitude!,
      //   currentLocation!.longitude!,
      // ));
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
                        k(_currentSubDistrict);
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
                  // child: currentLocation == null
                  //     ? Container()
                  //     : GoogleMap(
                  //         // gestureRecognizers: {
                  //         //   Factory<OneSequenceGestureRecognizer>(
                  //         //       () => EagerGestureRecognizer()),
                  //         // },
                  //         mapType: MapType.normal,
                  //         markers: _markers,
                  //         initialCameraPosition: _currentPlex as CameraPosition,
                  //         onMapCreated: (GoogleMapController controller) {
                  //           _controller.complete(controller);
                  //         },
                  //       ),
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
                              return Container(
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

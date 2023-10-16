import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fyp_project/constant.dart';
import 'dart:async';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MapLocationNew extends StatefulWidget {
  const MapLocationNew({super.key});

  @override
  State<MapLocationNew> createState() => _MapLocationNewState();
}

class _MapLocationNewState extends State<MapLocationNew> {
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
  LatLng? pointToLocation;
  late Stream listPlacesStream;
  String placeName = "";

  List<LatLng> polylineCoordinates = [];
  Map<String, dynamic> locationDetails = {
    'duration': '',
    'distance': '',
  };

  void getPolyPoints(LatLng destinationLocation) async {
    // print(destinationLocation.latitude);
    // print(destinationLocation.longitude);
    pointToLocation = destinationLocation;

    polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(currentLocation!.latitude as double,
          currentLocation!.longitude as double),
      PointLatLng(pointToLocation!.latitude, pointToLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      // setState(() {});
    }

    MapsProvider()
        .getDirections(
      currentLocation!.latitude as double,
      currentLocation!.longitude as double,
      pointToLocation!.latitude,
      pointToLocation!.longitude,
    )
        .then((value) {
      setState(() {
        locationDetails = value;
      });
    });
  }

  void getCurrentLocation() async {
    if (mounted) {
      Location location = Location();

      location.getLocation().then((location) {
        setState(() {
          currentLocation = location;
        });
      });

      // updateLocation();

      // location.enableBackgroundMode(enable: true);

      //somehow error
      // GoogleMapController googleMapController = await _controller.future;
      //
      // location.onLocationChanged.listen((newLoc) {
      //   currentLocation = newLoc;
      //   googleMapController.animateCamera(
      //     CameraUpdate.newCameraPosition(
      //       CameraPosition(
      //         zoom: 20.5,
      //         target: LatLng(newLoc.latitude!, newLoc.longitude!),
      //       ),
      //     ),
      //   );
      //   setState(() {});
      // });
    }
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

  void setPlaceName(String locationName) {
    setState(() {
      placeName = locationName;
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
    getPolyPoints(LatLng(
        point.latitude, point.longitude)); //->disable or enable getPolyPoints
  }

  void setCurrentPlex(LatLng point) {
    _currentPlex = CameraPosition(
      target: point,
      zoom: 14,
    );
  }

  // void goToLocation(String currentSubDistrict) async {
  //   List<Map<String, dynamic>> points =
  //       await Provider.of<MapsProvider>(context, listen: false)
  //           .listMarkersSubDistrict(
  //     _currentDistrict,
  //     currentSubDistrict,
  //   );

  //   goToPlace(LatLng(points.first['latitude'], points.first['longitude']));
  //   // getPolyPoints();
  //   //sini
  // }

  void listSubDistrict(String currentDistrict) async {
    // print(_currentDistrict);
    _subDistrict = await Provider.of<MapsProvider>(context, listen: false)
        .listSubDistrict(currentDistrict);
    setState(() {
      _currentSubDistrict = _subDistrict.first;
      initializeSubDistrict(_currentSubDistrict);
    });
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
    setPlaceName(points.first['locationName']);
    listPlacesStream =
        MapsProvider().listPlaces(_currentDistrict, _currentSubDistrict);
    // setCurrentPlex(LatLng(
    //     points.first['latitude'],
    //     points.first[
    //         'longitude'])); //this one should find nearest place, not first point of the subdistrict
  }

  void initialSubDistrict(currentDistrict) async {
    _subDistrict = await Provider.of<MapsProvider>(context, listen: false)
        .listSubDistrict(currentDistrict);
    _currentSubDistrict = _subDistrict.first;
    initializeSubDistrict(_currentSubDistrict);
    listPlacesStream =
        MapsProvider().listPlaces(_currentDistrict, _currentSubDistrict);
  }

  void listDistrict() async {
    _district =
        await Provider.of<MapsProvider>(context, listen: false).listDistrict();
    _currentDistrict = _district.first;
    initialSubDistrict(_currentDistrict);
  }

  // void updateLocation() async {
  //   //when user set go
  //   Location location = Location();
  //   location.changeSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 5,
  //   );

  //   GoogleMapController googleMapController = await _controller.future;

  //   location.onLocationChanged.listen((LocationData newLoc) {
  //     currentLocation = newLoc;
  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           zoom: 20.5,
  //           target: LatLng(newLoc.latitude!, newLoc.longitude!),
  //         ),
  //       ),
  //     );
  //     // setState(() {});
  //   });
  // }

  @override
  void initState() {
    getCurrentLocation();
    listDistrict();
    // listSubDistrict();
    listPlacesStream = Provider.of<MapsProvider>(context, listen: false)
        .listPlaces(_currentDistrict, _currentSubDistrict);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   updateLocation();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (currentLocation != null) {
      setCurrentPlex(LatLng(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ));
      // setYourPosMarker(LatLng(
      //   currentLocation!.latitude!,
      //   currentLocation!.longitude!,
      // ));
    }

    return SizedBox(
      width: size.width * 1,
      height: size.height * 0.84,
      child: currentLocation == null
          ? Container()
          // const SizedBox(
          //     child: Center(
          //       child:
          //           Text("Please enable location, tap to enable."),
          //     ),
          //   )
          :
          // null

          Stack(
              children: [
                AbsorbPointer(
                  absorbing: true,
                  child: GoogleMap(
                    //wrap dalam consumer?
                    // gestureRecognizers: {
                    //   Factory<OneSequenceGestureRecognizer>(
                    //       () => EagerGestureRecognizer()),
                    // },
                    mapType: MapType.normal,
                    markers: _markers,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _currentPlex as CameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    // polylines: {
                    //   Polyline(
                    //     polylineId: const PolylineId("route"),
                    //     points: polylineCoordinates,
                    //     color: Colors.blue,
                    //     width: 6,
                    //   )
                    // },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: size.height * 0.3,
                    width: size.width * 1,

                    // decoration: BoxDecoration(
                    //   color: Theme.of(context).colorScheme.primaryContainer,
                    //   borderRadius: const BorderRadius.only(
                    //     topRight: Radius.circular(25),
                    //     topLeft: Radius.circular(25),
                    //   ),
                    // ),
                    // decoration: decorationDefinedShadow(
                    //   Theme.of(context).colorScheme.primaryContainer,
                    //   30,
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: decorationDefined(
                              Theme.of(context).colorScheme.primaryContainer,
                              25),
                          child: districtBuilder(),
                        ),
                        Flexible(
                            // height: 50,
                            // width: size.width * 1,
                            child: listPlaces(size)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FilledButton.tonal(
                            onPressed: () async {
                              await launchUrl(Uri.parse(
                                  'google.navigation:q=${pointToLocation!.latitude}, ${pointToLocation!.longitude}&key=$googleApiKey'));
                            },
                            child: const Text("Go to place"),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  StreamBuilder<dynamic> listPlaces(Size size) {
    return StreamBuilder<dynamic>(
      stream: listPlacesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.hasData) {
            if (snapshot.hasError) {
              return Container();
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.first.length,
              itemBuilder: (context, i) {
                return Container(
                  width: size.width * 0.5,
                  // color: Colors.red,
                  margin: marginDefined,
                  decoration: decorationDefined(
                      Theme.of(context).colorScheme.primaryContainer, 25),
                  child: ListTile(
                      title: Text(
                        snapshot.data!.first[i]['name'],
                      ),
                      subtitle: placeName == snapshot.data!.first[i]['name']
                          ? Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                // Text(placeName),
                                Text(locationDetails['distance']),
                                Text(locationDetails['duration']),
                              ],
                            ).animate().fade().slide()
                          : Container(),
                      onTap: () {
                        goToPlace(
                          LatLng(
                            snapshot.data!.first[i]['latitude'],
                            snapshot.data!.first[i]['longitude'],
                          ),
                        );
                        setPlaceName(
                            snapshot.data!.first[i]['name'].toString());
                      }),
                );
              },
            ).animate().fadeIn(curve: Curves.easeIn);
          } else {
            return const Text("no data");
          }
        }
      },
    );
  }

  Row districtBuilder() {
    return Row(
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
                  initializeSubDistrict(_currentSubDistrict);
                });
                // print("curk:$_currentSubDistrict");
              },
            );
          },
        ),
        // TextButton(
        //   onPressed: () async {
        //     await launchUrl(Uri.parse(
        //         'google.navigation:q=${pointToLocation!.latitude}, ${pointToLocation!.longitude}&key=$googleApiKey'));
        //   },
        //   child: const Text("Go to place"),
        // ),
        const Spacer(),
        // IconButton(
        //   onPressed: () {
        //     setState(() {});
        //   },
        //   icon: const Icon(Icons.search),
        // ),
      ],
    );
  }
}

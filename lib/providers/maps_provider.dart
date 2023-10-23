import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import 'dart:convert' as convert;

class MapsProvider with ChangeNotifier {
  Stream<dynamic> listPlaces(
    String district,
    String subDistrict,
  ) async* {
    yield* FirebaseFirestore.instance
        .collection("places")
        .where("district", isEqualTo: district)
        .where("subDistrict", isEqualTo: subDistrict)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()['location']).toList());
  }

  Future<List<String>> listDistrict() async {
    List<String> listDistrict = [];

    await FirebaseFirestore.instance.collection("places").get().then((value) {
      for (var element in value.docs) {
        String district = element.data()['district'];

        if (!listDistrict.contains(district)) {
          listDistrict.add(district);
        }
      }
    });

    return listDistrict;
  }

  Future<List<String>> listSubDistrict(String targetDistrict) async {
    // String targetDistrict = "Kinta";
    List<String> listSubDistrict = [];

    await FirebaseFirestore.instance.collection("places").get().then((value) {
      for (var element in value.docs) {
        String subDistrict = element.data()['subDistrict'];
        String district = element.data()['district'];

        if (district == targetDistrict) {
          if (!listSubDistrict.contains(subDistrict)) {
            listSubDistrict.add(subDistrict);
          }
        }
      }
    });

    return listSubDistrict;
  }

  Future<List<Map<String, dynamic>>> listMarkersSubDistrict(
    String targetDistrict,
    String targetSubDistrict,
  ) async {
    // print(targetSubDistrict);
    // String targetDistrict = "Kinta";
    List<Map<String, dynamic>> listSubDistrict = [];

    await FirebaseFirestore.instance.collection("places").get().then((value) {
      for (var element in value.docs) {
        List<dynamic> location = element.data()['location'];
        String district = element.data()['district'];
        String subDistrict = element.data()['subDistrict'];

        if (district == targetDistrict) {
          // print("location all : $location");
          if (subDistrict == targetSubDistrict) {
            // print("location only with: $location");
            for (var locate in location) {
              listSubDistrict.add({
                "latitude": double.parse(locate['latitude']),
                "longitude": double.parse(locate['longitude']),
                "locationName": locate['name'],
              });
            }
          }
        }
      }
    });
    // print("list sub district: $listSubDistrict");
    return listSubDistrict;
  }

  Future<Map<String, dynamic>> getDirections(
    double originLat,
    double originLong,
    double destinationLat,
    double destinationLong,
  ) async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?destination=$destinationLat,$destinationLong&origin=$originLat,$originLong&key=$googleApiKey";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    // print(json['routes'][0]['legs'][0]['distance']);
    // print(json['routes'][0]['legs'][0]['duration']);
    // print(json['routes'][0]['legs'][0]['end_address']);
    // print(json['routes'][0]['legs'][0]);
    final details = {
      'duration': json['routes'][0]['legs'][0]['duration']['text'],
      'distance': json['routes'][0]['legs'][0]['distance']['text'],
    };

    return details;
  }
}

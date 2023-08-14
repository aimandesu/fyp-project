import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                "latitude": locate['latitude'],
                "longitude": locate['longitude'],
              });
            }
          }
        }
      }
    });
    // print("list sub district: $listSubDistrict");
    return listSubDistrict;
  }
}

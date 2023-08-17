import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  Future<Map<String, dynamic>> fetchOwnProfile(
      // String identificationNo,
      // String group, //comunity or organization
      ) async {
    // final userUID = FirebaseAuth.instance.currentUser;

    final instance = await FirebaseFirestore.instance
        .collection("community")
        .where("userUID", isEqualTo: "r2ZtAZjZaQVisEdfYUqM")
        // .where("identificationNo", isEqualTo: identificationNo)
        .get();

    final data = instance.docs.first.data();
    return data;
  }
}


// print(data);
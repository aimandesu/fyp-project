import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/user_model.dart';

class ProfileProvider with ChangeNotifier {
  Future<Map<String, dynamic>> fetchOwnProfile(
      // String identificationNo,
      // String group, //comunity or organization
      ) async {
    // final userUID = FirebaseAuth.instance.currentUser;
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final instance = await FirebaseFirestore.instance
        .collection("community")
        .where("authUID", isEqualTo: authUID)
        .where("identificationNo", isNotEqualTo: "")
        // .where("identificationNo", isEqualTo: identificationNo)
        .get();

    final data = instance.docs.first.data();
    return data;
  }

  // static Future<void> updateProfile(UserModel userModel){

  // }
}


// print(data);
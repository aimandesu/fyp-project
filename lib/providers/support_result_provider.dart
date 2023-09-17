import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupportResultProvider with ChangeNotifier {
  Future<bool> getResult() async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final instance = await FirebaseFirestore.instance
        .collection("form")
        .where("authUID", isEqualTo: authUID)
        .where("reviewed", isEqualTo: false)
        .get();

    return instance.docs
        .isEmpty; //if reviewed == false, result is false, if reviewed == true, result is true
  }
}

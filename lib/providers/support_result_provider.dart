import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupportResultProvider with ChangeNotifier {
  Future<Map<String, dynamic>?> getResult(String docPath) async {
    final instance = await FirebaseFirestore.instance
        .collection("form")
        .doc(docPath)
        .get()
        .then((event) => event.data());

    return instance; //if reviewed == false, result is false, if reviewed == true, result is true
  }

  Future<List<Map<String, dynamic>>> getAppliedForm() async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final instance = await FirebaseFirestore.instance
        .collection("form")
        .where("authUID", isEqualTo: authUID)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    return instance;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  static void askAssistance() async {
    //do checking first
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    final askAssistance =
        FirebaseFirestore.instance.collection("requestAssistance");

    final bool checkSession = await askAssistance
        .where("isPicked", isEqualTo: true)
        .where("userUID", isEqualTo: userUID)
        .get()
        .then((value) => value.docs.isEmpty);

    if (checkSession) {
      askAssistance.add({
        "isPicked": false,
        "assistanceID": "",
        "userUID": userUID,
        "date": DateTime.now(),
        "requestID": "",
      }).then((value) {
        askAssistance.doc(value.id).update({
          "requestID": value.id,
        });
      });
    }
  }

  void deleteAssistanceRequest() async {
    final userUID = FirebaseAuth.instance.currentUser!.uid;

    final collection = FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("userUID", isEqualTo: userUID)
        .get();

    collection.then((value) async {
      if (value.docs.first.data()['assistanceID'] == "" &&
          value.docs.first.data()['isPicked'] == false) {
        final snapshot = await collection;
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          await doc.reference.delete();
        }
      }
    });
  }

  Future<String> getRequestID() async {
    final userUID = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("userUID", isEqualTo: userUID)
        .where("isPicked", isEqualTo: true)
        .get();
    return doc.docs.first.data()['requestID'];
  }

  // Stream<bool> hasPicked() async* {
  //   final userUID = FirebaseAuth.instance.currentUser!.uid;
  //
  //   yield* FirebaseFirestore.instance
  //       .collection("requestAssistance")
  //       .where("userUID", isEqualTo: userUID)
  //       .snapshots()
  //       .map((doc) =>
  //           doc.docs.first.data()['assistanceID'] != "" &&
  //           doc.docs.first.data()['isPicked'] != false);
  // }

  Stream<List<Map<String, dynamic>>> fetchChat(String requestID) async* {
    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(requestID)
        .collection("chat")
        .orderBy("index", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  void addMessage() {}
}

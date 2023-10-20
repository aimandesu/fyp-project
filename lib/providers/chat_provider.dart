import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  Future<String> askAssistance() async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;
    final askAssistance =
        FirebaseFirestore.instance.collection("requestAssistance");
    String requestIDtoPass = "";

    final documentReference = await askAssistance.add({
      "isPicked": false,
      "assistanceID": "",
      "authUID": authUID,
      "date": DateTime.now(),
      "requestID": "",
    });

    requestIDtoPass = documentReference.id;
    await askAssistance.doc(requestIDtoPass).update({
      "requestID": requestIDtoPass,
    });
    // askAssistance.doc(requestIDtoPass).collection("chat");

    return requestIDtoPass;
  }

  void deleteAssistanceRequest() async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final collection = FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("authUID", isEqualTo: authUID)
        .get();

    collection.then((value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        if (doc.data()['assistanceID'] == "" &&
            doc.data()['isPicked'] == false) {
          await doc.reference.delete();
        }
      }
    });
  }

  // Future<String> getRequestID() async {
  //   final authUID = FirebaseAuth.instance.currentUser!.uid;
  //   final doc = await FirebaseFirestore.instance
  //       .collection("requestAssistance")
  //       .where("authUID", isEqualTo: authUID)
  //       .where("requestID", isNotEqualTo: "")
  //       .where("isPicked", isEqualTo: true)
  //       .get();
  //   return doc.docs.first.data()['requestID'];
  // }

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

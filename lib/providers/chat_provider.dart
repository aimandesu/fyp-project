import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  static void askAssistance() {
    //FirebaseAuth.instance.currentUser
    FirebaseFirestore.instance
        .collection("requestAssistance")
        .add({"isPicked": false, "pickedBy": "", "userUID": "userUID"});
  }

  Stream<bool> hasPicked() async* {
    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("isPicked", isEqualTo: false)
        .where("userUID", isEqualTo: "userUID")
        .snapshots()
        .map((doc) => doc.docs.first.data()['pickedBy'] != "");
  }
}

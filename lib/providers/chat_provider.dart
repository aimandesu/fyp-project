import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/message_model.dart';

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
        if (doc.data()['isPicked'] == false) {
          await doc.reference.delete();
        } else {
          final thePath = FirebaseFirestore.instance
              .collection("requestAssistance")
              .doc(doc.data()["requestID"])
              .collection("chat");
          final lengthMessage =
              await thePath.get().then((value) => value.docs.length);
          await thePath.add({
            'index': lengthMessage,
            'uid': authUID,
            'text': "exit",
          });
        }
      }
    });
  }

  Stream<List<Map<String, dynamic>>> fetchChat(String requestID) async* {
    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(requestID)
        .collection("chat")
        .orderBy("index", descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  void addMessage(
    MessageModel messageModel,
  ) async {
    Reference reference = FirebaseStorage.instance.ref();
    String pathFiles = "message/${messageModel.uid}/${messageModel.requestID}";
    String imgUrl = "";
    if (messageModel.picture != null) {
      try {
        Reference referenceDirectory = reference.child(pathFiles);
        await referenceDirectory.putFile(messageModel.picture as File);
        String url = await referenceDirectory.getDownloadURL();
        imgUrl = url;
      } on FirebaseException catch (e) {
        print(e.message.toString());
        //ke here kena guna technique alert stack trace
      }
    }

    final collection = FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(messageModel.requestID)
        .collection("chat");

    final lengthMessage =
        await collection.get().then((value) => value.docs.length);
    final int index = lengthMessage;
    final json = messageModel.toJson(imgUrl, index);
    await collection.add(json);
  }
}

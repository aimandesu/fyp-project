import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        // .where("identificationNo", isNotEqualTo: "")
        // .where("identificationNo", isEqualTo: identificationNo)
        .get();

    final data = instance.docs.first.data();
    return data;
  }

  Future<void> updateProfile(
    UserModel userModel,
    BuildContext context,
    String docPath,
  ) async {
    String pathFiles =
        "profile/${userModel.communityAt['subDistrict']}/${userModel.identificationNo}";

    Map<String, String> identificationImage = {
      'back': '',
      'front': '',
    };

    Reference reference = FirebaseStorage.instance.ref();

    try {
      final collection = FirebaseFirestore.instance.collection("community");
      // for (int i = 0; i < userModel.identificationImage!.length; i++) {
      userModel.identificationImage!.forEach((key, value) async {
        Reference referenceDirectory = reference.child("$pathFiles/$key");
        await referenceDirectory.putFile(value);
        String url = await referenceDirectory.getDownloadURL();

        identificationImage.update(
            key, (value) => url); //way to update map concept

        if (identificationImage['front'] != '' &&
            identificationImage['back'] != '') {
          final data = userModel.toJson(identificationImage);

          collection.doc(docPath).update(data);
        }
      });

      // String imagePos = "";

      // i == 0
      //     ? imagePos = "back"
      //     : imagePos = "front"; //here kena control logic dia

      // Reference referenceDirectory = reference.child("$pathFiles/$imagePos");
      // await referenceDirectory
      //     .putFile(userModel.identificationImage![imagePos] as File);
      // String url = await referenceDirectory.getDownloadURL();

      // identificationImage.update(
      //     imagePos, (value) => url); //way to update map concept
      // }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
      }
    }

    // Future<Map<String, dynamic>> fetchUpdatedProfile(
    //     // String identificationNo,
    //     // String group, //comunity or organization
    //     ) async {

    //     }
  }
}


// print(data);
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/helpform_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class HelpFormProvider {
  static Future<void> sendHelpForm(
    HelpFormModel helpFormModel,
    BuildContext context,
  ) async {
    DateTime now = DateTime.now();

    //for storage
    String formatter = DateFormat.yMMMMd('en_US').format(now);

    //for database
    DateTime date =  DateTime(now.year, now.month, now.day);

    String pathFiles =
        "form/individual/${helpFormModel.district}/${helpFormModel.noIC}/$formatter";

    //url
    String pdfUrl = "";
    List<String> imgUrl = [];

    Reference reference = FirebaseStorage.instance.ref();

    try {
      //pdf url
      final data = await helpFormModel.selectedPDF.readAsBytes();
      Reference referenceDirectory = reference.child("$pathFiles/file");
      await referenceDirectory.putData(
        data,
        SettableMetadata(
          contentType: 'application/pdf',
          customMetadata: {'fileType': 'pdf'},
        ),
      );
      pdfUrl = await referenceDirectory.getDownloadURL();

      //picture url
      for (int i = 0; i < helpFormModel.pictures.length; i++) {
        final contentType = getImageContentType(helpFormModel.pictures[i]);
        Reference referenceDirectory = reference.child(
          "$pathFiles/cases/${helpFormModel.pictures[i].uri.pathSegments.last}",
        );
        await referenceDirectory.putFile(
          helpFormModel.pictures[i],
          SettableMetadata(
            contentType: contentType,
            customMetadata: {'fileType': 'image'},
          ),
        );
        String url = await referenceDirectory.getDownloadURL();
        imgUrl.add(url);
      }
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
      //ke here kena guna technique alert stack trace
    } finally {
      final helpForm = FirebaseFirestore.instance.collection("form");
      final json = helpFormModel.toJson(pdfUrl, imgUrl, date);
      await helpForm.add(json).then((value) {
        helpForm.doc(value.id).update({
          "caseID": value.id,
        });
      });
    }
  }

  Future<bool> hasIdentificationVerified() async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;
    final instance = await FirebaseFirestore.instance
        .collection("community")
        .where("authUID", isEqualTo: authUID)
        .get();

    bool data = instance.docs.first.data()["identificationNo"] != "";

    return data;
  }
}

String getImageContentType(File file) {
  final fileExtension = file.path.split('.').last.toLowerCase();
  if (fileExtension == 'jpeg' || fileExtension == 'jpg') {
    return 'image/jpeg';
  } else if (fileExtension == 'png') {
    return 'image/png';
  } else if (fileExtension == 'gif') {
    return 'image/gif';
  } else if (fileExtension == 'bmp') {
    return 'image/bmp';
  } else if (fileExtension == 'webp') {
    return 'image/webp';
  }
  // Add more image types as needed

  // Default to 'application/octet-stream' for unknown file types
  return 'application/octet-stream';
}

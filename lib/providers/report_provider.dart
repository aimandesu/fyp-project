import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/report_incidence_model.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ReportProvider {
  static Future<void> submitIncident(
    ReportIncidenceModel reportIncidenceModel,
    BuildContext context,
  ) async {
    DateTime now = DateTime.now();
    String formatter = DateFormat.yMMMMd('en_US').format(now);

    //send form
    String pathFiles = "report/incidence/$formatter";

    List<String> imgUrl = [];
    Reference reference = FirebaseStorage.instance.ref();

    try {
      for (int i = 0; i < reportIncidenceModel.pictures.length; i++) {
        final contentType =
            getImageContentType(reportIncidenceModel.pictures[i]);
        Reference referenceDirectory = reference.child(
          "$pathFiles/${reportIncidenceModel.userUID}/${reportIncidenceModel.pictures[i].uri.pathSegments.last}",
        );
        await referenceDirectory.putFile(
          reportIncidenceModel.pictures[i],
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
    } finally {
      final instance = FirebaseFirestore.instance.collection("report");
      final json = reportIncidenceModel.toJson(imgUrl, formatter);
      await instance.add(json).then((value) {
        instance.doc(value.id).update({
          "reportID": value.id,
        });
      });
    }
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/helpform_model.dart';

class HelpFormProvider {
  static Future<void> sendHelpForm(
    HelpFormModel helpFormModel,
    BuildContext context,
  ) async {
    String pathFiles =
        "form/individual/${helpFormModel.district}/${helpFormModel.noIC}";

    //url
    String pdfUrl = "";
    List<String> imgUrl = [];

    Reference reference = FirebaseStorage.instance.ref();

    try {
      //pdf url
      final data = await helpFormModel.selectedPDF.readAsBytes();
      Reference referenceDirectory = reference.child("$pathFiles/file");
      await referenceDirectory.putData(data);
      pdfUrl = await referenceDirectory.getDownloadURL();

      //picture url
      for (var picture in helpFormModel.pictures) {
        Reference referenceDirectory = reference.child("$pathFiles/cases");
        await referenceDirectory.putFile(picture);
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
      final helpForm = FirebaseFirestore.instance.collection('form');
      final json = helpFormModel.toJson(pdfUrl, imgUrl);
      await helpForm.add(json).then((value) {
        helpForm.doc(value.id).update({
          "caseID": value.id,
        });
      });
    }
  }
}

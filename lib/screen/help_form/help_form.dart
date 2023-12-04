import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/models/helpform_model.dart';
import 'package:fyp_project/providers/helpform_provider.dart';
import 'package:fyp_project/screen/help_form/widgets/inputField/list_household.dart';
import 'package:fyp_project/screen/help_form/widgets/inputField/proof_verification.dart';
import 'package:fyp_project/screen/help_form/widgets/inputField/victim_category.dart';
import 'package:fyp_project/screen/help_form/widgets/inputField/your_information.dart';
import 'package:fyp_project/screen/help_form/widgets/pdf/pdf_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_upload.dart';

class HelpForm extends StatefulWidget {
  const HelpForm({super.key});

  @override
  State<HelpForm> createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final noICController = TextEditingController();
  final postcodeController = TextEditingController();
  final subDistrictController = TextEditingController(text: "Ipoh");
  String gender = "Lelaki";
  final ageController = TextEditingController();
  String category = "Berpindah ke PPS";
  final List<Map<String, TextEditingController>> listFamilies = [];

  File? selectedPDF;
  List<File>? pictures = [];

  void changeGender(String value) {
    setState(() {
      gender = value;
    });
  }

  void changeCategory(String value) {
    setState(() {
      category = value;
    });
  }

  void addFamilyMember() {
    int index = listFamilies.length;
    Map<String, TextEditingController> controllers = {
      'name$index': TextEditingController(),
      'age$index': TextEditingController(),
      'ICno$index': TextEditingController(),
      'relationship$index': TextEditingController(),
    };

    setState(() {
      listFamilies.add(controllers);
    });
  }

  void removeLast() {
    if (listFamilies.isEmpty) return;
    setState(() {
      listFamilies.removeLast();
    });
  }

  void collectDataAndSend() {
    List<Map<String, String>> data = [];

    for (var controllers in listFamilies) {
      Map<String, String> newDataEntry = {};

      controllers.forEach((key, value) {
        key = key.replaceAll(RegExp(r'[0-9]'), '');
        newDataEntry[key] = value.text;
      });

      data.add(newDataEntry);
    }

    if (nameController.text == "" ||
        addressController.text == "" ||
        postcodeController.text == "" ||
        phoneController.text == "" ||
        noICController.text == "" ||
        ageController.text == "" ||
        selectedPDF == null ||
        pictures == null) {
      popSnackBar(context, "Ada informasi tidak lengkap");
      return;
    }

    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final helpForm = HelpFormModel(
      name: nameController.text,
      address: addressController.text,
      postcode: postcodeController.text,
      subDistrict: subDistrictController.text,
      phone: phoneController.text,
      noIC: noICController.text,
      gender: gender,
      age: int.parse(ageController.text),
      category: category,
      selectedPDF: selectedPDF as File,
      pictures: pictures as List<File>,
      familyMembers: data,
      authUID: authUID,
    );

    //try send data
    HelpFormProvider.sendHelpForm(helpForm, context).whenComplete(() {
      Navigator.pop(context);
      popSnackBar(context, "Permohonan bantuan dihantar.");
    }).onError((error, stackTrace) => popSnackBar(context, error.toString()));
    //call alert dialog
    popLoadingDialog(context);

    //clear all text field
    _clearTextFields();
  }

  void _clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    noICController.clear();
    postcodeController.clear();
    subDistrictController.clear();
    ageController.clear();
    for (var controllers in listFamilies) {
      // deleteField(_listFamilies.indexOf(controllers));
      for (var controller in controllers.values) {
        controller.clear();
      }
    }
  }

  //pictures and pdf callback

  Future<void> navigatePictureUpload(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      PictureUpload.routeName,
      arguments: {"pictures": pictures},
    );
    if (!mounted) return;
    setState(() {
      pictures = result as List<File>?;
    });
  }

  Future<void> navigatePDFUpload(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      PDFUpload.routeName,
      arguments: {"pdf": selectedPDF},
    );
    if (!mounted) return;

    Map<String, dynamic> resultMap = result as Map<String, dynamic>;

    setState(() {
      selectedPDF = resultMap["pdf"] as File?;
    });

    if (resultMap["showUpload"]) {
      popSnackBar(context, "PDF berjaya diupload");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    noICController.dispose();
    postcodeController.dispose();
    subDistrictController.dispose();
    ageController.dispose();
    for (var controllers in listFamilies) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HelpFormProvider().hasIdentificationVerified(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!["identificationNo"] == "") {
            return const Text("Please verify identity first");
          }

          if (snapshot.data!["verified"] == false) {
            return const Text("identification is being reviewed");
          }

          if (snapshot.data!["identificationNo"] != "" &&
              snapshot.data!["verified"] != false) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  YourInformation(
                    nameController: nameController,
                    noICController: noICController,
                    addressController: addressController,
                    phoneController: phoneController,
                    ageController: ageController,
                    gender: gender,
                    changeGender: changeGender,
                    subDistrictController: subDistrictController,
                    postcodeController: postcodeController,
                  ),
                  VictimCategory(
                    category: category,
                    changeCategory: changeCategory,
                  ),
                  ListHousehold(
                    listFamilies: listFamilies,
                    addFamilyMember: addFamilyMember,
                    removeLast: removeLast,
                  ),
                  ProofVerification(
                    pictures: pictures,
                    navigatePictureUpload: navigatePictureUpload,
                    navigatePDFUpload: navigatePDFUpload,
                    selectedPDF: selectedPDF,
                  ),
                  submitButton(context),
                ].animate(interval: 40.ms).fade(duration: 300.ms),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Align submitButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: marginDefined,
        padding: paddingDefined,
        child: FilledButton.tonal(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.all(20),
            ),
          ),
          onPressed: collectDataAndSend,
          child: const Icon(Icons.send),
        ),
      ),
    );
  }
}

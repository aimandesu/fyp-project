import 'dart:io';
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
  final districtController = TextEditingController();
  String gender = "male";
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
    // print(data); [{}, {}]
    try {
      final authUID = FirebaseAuth.instance.currentUser!.uid;

      final helpForm = HelpFormModel(
        name: nameController.text,
        address: addressController.text,
        postcode: postcodeController.text,
        district: districtController.text,
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

      HelpFormProvider.sendHelpForm(helpForm, context);
      _clearTextFields();
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("There is input field that is not completed"),
          duration:
              Duration(seconds: 2), // You can adjust the duration as needed
        ),
      );
    }
  }

  void _clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    noICController.clear();
    postcodeController.clear();
    districtController.clear();
    ageController.clear();
    for (var controllers in listFamilies) {
      // deleteField(_listFamilies.indexOf(controllers));
      for (var controller in controllers.values) {
        controller.clear();
      }
    }
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF uploaded successfully!'),
          duration:
              Duration(seconds: 2), // You can adjust the duration as needed
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    noICController.dispose();
    postcodeController.dispose();
    districtController.dispose();
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
    //we will have name, address, phone no, and salinan pengesahan from ketua kampung
    //create function from here to take files, then pass it to filesUpload, if files is
    //fullfill then put checkbox
    //maybe if we proceed, then the will be volunteer comes and take a look first at damage done?

    /*
    here I want to check if the user has gone through ic or not, if not denied the request that
    the user can proceed with this thing
     */

    return FutureBuilder<bool>(
      future: HelpFormProvider().hasIdentificationVerified(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            return const Text("Please verify identity first");
          } else {
            return SingleChildScrollView(
              //make future to ask user to sign in and wait for confirmation of their profile, or something like that
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
                    districtController: districtController,
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
                ].animate(interval: 40.ms).fade(duration: 300.ms).slideY(),
              ),
            );
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

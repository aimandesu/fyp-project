import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/models/helpform_model.dart';
import 'package:fyp_project/screen/help_form/widgets/files_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/images_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/pdf/pdf_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/table_input.dart';
import 'package:fyp_project/screen/help_form/widgets/textfield_decoration.dart';

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
  final List<Map<String, TextEditingController>> _listFamilies = [];

  File? _selectedPDF;
  List<File>? _pictures = [];

  void _addFamilyMember() {
    int index = _listFamilies.length;
    Map<String, TextEditingController> controllers = {
      'name$index': TextEditingController(),
      'age$index': TextEditingController(),
      'ICno$index': TextEditingController(),
      'relationship$index': TextEditingController(),
    };

    setState(() {
      _listFamilies.add(controllers);
    });
  }

  void _removeLast() {
    if (_listFamilies.isEmpty) return;
    setState(() {
      _listFamilies.removeLast();
    });
  }

  void _collectdataAndSend(BuildContext context) {
    List<Map<String, String>> data = [];

    for (var controllers in _listFamilies) {
      Map<String, String> newDataEntry = {};

      controllers.forEach((key, value) {
        key = key.replaceAll(RegExp(r'[0-9]'), '');
        newDataEntry[key] = value.text;
      });

      data.add(newDataEntry);
    }
    // print(data); [{}, {}]

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
      selectedPDF: _selectedPDF as File,
      pictures: _pictures as List<File>,
      familyMembers: data,
    );

    _clearTextFields();
  }

  void _clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    noICController.clear();
    ageController.clear();
    for (var controllers in _listFamilies) {
      // deleteField(_listFamilies.indexOf(controllers));
      for (var controller in controllers.values) {
        controller.clear();
      }
    }
  }

  Future<void> _navigatePictureUpload(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      PictureUpload.routeName,
      arguments: {"pictures": _pictures},
    );
    if (!mounted) return;
    setState(() {
      _pictures = result as List<File>?;
    });
  }

  Future<void> _navigatePDFUpload(BuildContext context) async {
    var result = await Navigator.pushNamed(
      context,
      PDFUpload.routeName,
      arguments: {"pdf": _selectedPDF},
    );
    if (!mounted) return;

    Map<String, dynamic> resultMap = result as Map<String, dynamic>;

    setState(() {
      _selectedPDF = resultMap["pdf"] as File?;
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    noICController.dispose();
    ageController.dispose();
    for (var controllers in _listFamilies) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //we will have name, address, phone no, and salinan pengesahan from ketua kampung
    //create function from here to take files, then pass it to filesUpload, if files is
    //fullfill then put checkbox
    //maybe if we proceed, then the will be volunteer comes and take a look first at damage done?

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GestureDetector(
          //   onTap: () => _navigatePictureUpload(context),
          //   child:
          const Padding(
            padding: paddingDefined,
            child: Text(
              "Maklumat Anda",
              style: textStyling,
            ),
          ),
          definedInput(context, "Name", nameController),
          definedInput(context, "No Kad Pengenalan", noICController),
          genderAndAgeInput(size, context),
          definedInput(context, "Alamat", addressController),
          const Padding(
            padding: paddingDefined,
            child: Text(
              "Kategori Mangsa",
              style: textStyling,
            ),
          ),
          kategoriMangsa(size, context),
          const Padding(
            padding: paddingDefined,
            child: Text(
              "Senarai isi rumah",
              style: textStyling,
            ),
          ),
          TableInput(
            listFamilies: _listFamilies,
          ),
          tableDecision(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: marginDefined,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ImagesUpload(
                    navigatePictureUpload: _navigatePictureUpload,
                    pictures: _pictures,
                  ),
                  const Padding(padding: paddingDefined),
                  FilesUpload(
                    fileName: "Pengesahan Ketua Kampung",
                    navigatePDFUpload: _navigatePDFUpload,
                    selectedPDF: _selectedPDF,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => _collectdataAndSend,
            icon: const Icon(Icons.send),
          ),
          // ),
        ],
      ),
    );
  }

  //method taken out

  Row tableDecision() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: marginDefined,
            child: ElevatedButton(
                onPressed: _addFamilyMember,
                child: const Text("Tambah Ahli Keluarga")),
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            child: ElevatedButton(
                onPressed: _removeLast, child: const Text("Padam ")),
          ),
        )
      ],
    );
  }

  Container definedInput(
    BuildContext context,
    String hintText,
    TextEditingController textEditingController,
  ) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      height: 60,
      decoration: inputDecorationDefined(context),
      child: TextFieldDecoration(
        hintText: hintText,
        textInputType: TextInputType.name,
        textEditingController: textEditingController,
      ),
    );
  }

  Row genderAndAgeInput(Size size, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            // width: size.width * 0.3,
            decoration: inputDecorationDefined(context),
            child: TextFieldDecoration(
              hintText: "No Telefon",
              textInputType: TextInputType.phone,
              textEditingController: phoneController,
            ),
          ),
        ),
        Expanded(
          child: Container(
            // margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            // width: size.width * 0.3,
            decoration: inputDecorationDefined(context),
            child: DropdownButton(
              value: gender,
              isExpanded: true,
              // hint: Text("gender"),
              onChanged: (String? value) {
                setState(() {
                  gender = value!;
                });
              },
              items: ["male", "female"].map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          margin: marginDefined,
          padding: paddingDefined,
          height: 60,
          width: size.width * 0.2,
          decoration: inputDecorationDefined(context),
          child: TextFieldDecoration(
            hintText: "Umur",
            textInputType: TextInputType.number,
            textEditingController: ageController,
          ),
        ),
      ],
    );
  }

  Container kategoriMangsa(Size size, BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      height: 60,
      width: size.width * 1,
      decoration: inputDecorationDefined(context),
      child: DropdownButton(
        isExpanded: true,
        value: category,
        // hint: Text("gender"),
        onChanged: (String? value) {
          setState(() {
            category = value!;
          });
        },
        items: [
          "Berpindah ke PPS",
          "Berpindah Ke Selain PPS",
          "Tidak Berpindah",
          "Pemilik Gerai / Rumah Kedai",
          "Pemilik Rumah",
          "Penyewa Rumah",
        ].map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

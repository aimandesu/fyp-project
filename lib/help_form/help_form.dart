import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/help_form/widgets/files_upload.dart';
import 'package:fyp_project/help_form/widgets/picture_display.dart';
import 'package:fyp_project/help_form/widgets/picture_upload.dart';
import 'package:fyp_project/help_form/widgets/textfield_decoration.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'package:image_picker/image_picker.dart';

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
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final List<Map<String, TextEditingController>> _listFamilies = [];

  List<File>? _pictures = [];

  void _addFamilyMember() {
    int index = _listFamilies.length;
    Map<String, TextEditingController> controllers = {
      'Nama$index': TextEditingController(),
      'Umur$index': TextEditingController(),
      'No IC$index': TextEditingController(),
      'Hubungan$index': TextEditingController(),
    };

    setState(() {
      _listFamilies.add(controllers);
    });
  }

  void deleteField(int index) {
    setState(() {
      _listFamilies.removeAt(index);
    });
    print(_listFamilies.length);
  }

  void _collectData() {
    print(_listFamilies.length);
    List<Map<String, String>> data = [];
    for (var controllers in _listFamilies) {
      int i = _listFamilies.indexOf(controllers);
      print(i);
      // data.add({
      //   "Nama": controllers['Nama$i']!
      //       .text, //why 1? kita delete index 0 but dia controller 1, bukn i = 0 sbb tu error
      //   "Umur": controllers['Umur$i']!.text,
      //   "No IC": controllers['No IC$i']!.text,
      //   "Hubungan": controllers['Hubungan$i']!.text,
      // });
    }
    print(data);
    _clearTextFields();
  }

  void _clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    noICController.clear();
    genderController.clear();
    ageController.clear();
    for (var controllers in _listFamilies) {
      // deleteField(_listFamilies.indexOf(controllers));
      for (var controller in controllers.values) {
        controller.clear();
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    noICController.dispose();
    genderController.dispose();
    ageController.dispose();
    for (var controllers in _listFamilies) {
      for (var controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _removePicture(int index) {
    setState(() {
      _pictures = _pictures!..removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _navigatePictureUpload(BuildContext context) async {
    var result =
        await Navigator.pushNamed(context, PictureUpload.routeName, arguments: {
      "pictures": _pictures,
    });
    if (!mounted) return;
    setState(() {
      _pictures = result as List<File>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //we will have name, address, phone no, and salinan pengesahan from ketua kampung
    //create function from here to take files, then pass it to filesUpload, if files is
    //fullfill then put checkbox
    //maybe if we proceed, then the will be volunteer comes and take a look first at damage done?

    return SingleChildScrollView(
      child: ResponsiveLayoutController(
        mobile: Column(
          children: [
            // GestureDetector(
            //   onTap: () => _navigatePictureUpload(context),
            //   child:
            PictureDisplay(
              height: size.height * 0.3,
              width: size.width * 1,
              pictures: _pictures as List<File>,
              navigatePictureUpload: _navigatePictureUpload,
            ),
            // ),
            nameAndPhoneInput(size, context),
            definedInput(context, "No Kad Pengenalan", noICController),
            genderAndAgeInput(size, context),
            definedInput(context, "Alamat", addressController),
            const Text("Kategori Mangsa"),
            _listFamilies.isEmpty ? Container() : tableInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _addFamilyMember,
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: _collectData,
                  icon: Icon(Icons.get_app),
                ),
              ],
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilesUpload(fileName: "Surat Pengesahan Ketua Kampung"),
                  FilesUpload(fileName: "Surat Pengesahan Imam Kampung"),
                ],
              ),
            ),
          ],
        ),
        tablet: Column(
          children: [
            PictureDisplay(
              height: 300,
              width: size.width * 1,
              pictures: _pictures as List<File>,
              navigatePictureUpload: _navigatePictureUpload,
            ),
            nameAndPhoneInput(size, context),
            definedInput(context, "No Kad Pengenalan", noICController),
            genderAndAgeInput(size, context),
            definedInput(context, "Alamat", addressController),
            const Text("Kategori Mangsa"),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilesUpload(fileName: "Surat Pengesahan Ketua Kampung"),
                  FilesUpload(fileName: "Surat Pengesahan Imam Kampung"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView tableInput() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('Umur')),
              DataColumn(label: Text('No IC')),
              DataColumn(label: Text('Hubungan')),
              DataColumn(label: Text("Padam"))
            ],
            rows: _listFamilies.map<DataRow>((controllers) {
              return DataRow(cells: [
                DataCell(TextField(
                    controller: controllers[
                        'Nama${_listFamilies.indexOf(controllers)}'])),
                DataCell(TextField(
                    controller: controllers[
                        'Umur${_listFamilies.indexOf(controllers)}'])),
                DataCell(TextField(
                    controller: controllers[
                        'No IC${_listFamilies.indexOf(controllers)}'])),
                DataCell(TextField(
                    controller: controllers[
                        'Hubungan${_listFamilies.indexOf(controllers)}'])),
                DataCell(IconButton(
                    onPressed: () =>
                        deleteField(_listFamilies.indexOf(controllers)),
                    icon: const Icon(Icons.delete)))
              ]);
            }).toList(),
          ),
        ],
      ),
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

  Row nameAndPhoneInput(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          margin: marginDefined,
          padding: paddingDefined,
          height: 60,
          width: size.width * 0.6,
          decoration: inputDecorationDefined(context),
          child: TextFieldDecoration(
            hintText: "Nama",
            textInputType: TextInputType.name,
            textEditingController: nameController,
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            decoration: inputDecorationDefined(context),
            child: TextFieldDecoration(
              hintText: "No Telefon",
              textInputType: TextInputType.name,
              textEditingController: phoneController,
            ),
          ),
        ),
      ],
    );
  }

  Row genderAndAgeInput(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          margin: marginDefined,
          padding: paddingDefined,
          height: 60,
          width: size.width * 0.5,
          decoration: inputDecorationDefined(context),
          child: TextFieldDecoration(
            hintText: "Jantina",
            textInputType: TextInputType.name,
            textEditingController: genderController,
          ),
        ),
        Expanded(
          child: Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            decoration: inputDecorationDefined(context),
            child: TextFieldDecoration(
              hintText: "Umur",
              textInputType: TextInputType.name,
              textEditingController: ageController,
            ),
          ),
        ),
      ],
    );
  }
}

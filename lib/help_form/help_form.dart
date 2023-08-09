import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/help_form/widgets/files_upload.dart';
import 'package:fyp_project/help_form/widgets/textfield_decoration.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

class HelpForm extends StatefulWidget {
  const HelpForm({super.key});

  @override
  State<HelpForm> createState() => _HelpFormState();
}

class _HelpFormState extends State<HelpForm> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  void clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //we will have name, address, phone no, and salinan pengesahan from ketua kampung
    //create function from here to take files, then pass it to filesUpload, if files is
    //fullfill then put checkbox
    //maybe if we proceed, then the will be volunteer comes and take a look first at damage done?

    return ResponsiveLayoutController(
      mobile: Column(
        children: [
          Container(
            margin: marginDefined,
            // color: Colors.red,
            height: size.height * 0.3,
            width: size.width * 1,
            decoration: inputDecorationDefined(context),
            child: const Center(
              child: Text("Ambil Gambar"),
            ),
          ),
          Row(
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
          ),
          Container(
            margin: marginDefined,
            padding: paddingDefined,
            height: 60,
            decoration: inputDecorationDefined(context),
            child: TextFieldDecoration(
              hintText: "Alamat",
              textInputType: TextInputType.name,
              textEditingController: addressController,
            ),
          ),
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
      tablet: const Text("table"),
    );
  }
}

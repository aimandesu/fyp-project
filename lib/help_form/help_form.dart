import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/help_form/widgets/files_upload.dart';
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
  List<File>? _pictures = [];

  void _clearTextFields() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
  }

  // void _picturesAvailable() async {
  //   List<File>? updatedPictures = await Navigator.of(context)
  //       .pushNamed(PictureUpload.routeName, arguments: _pictures);
  //   // print(updatedPictures!.length);
  //   // if (updatedPictures == null) {
  //   //   print("null");
  //   // }
  //   // if (updatedPictures != null) {
  //   //   setState(() {
  //   //     _pictures = updatedPictures;
  //   //   });
  //   // }
  // }

  // @override
  // void didChangeDependencies() {
  //   _picturesAvailable();
  //   super.didChangeDependencies();
  // }

  void _removePicture(int index) {
    setState(() {
      _pictures = _pictures!..removeAt(index);
    });
  }

  @override
  void initState() {
    // _picturesAvailable();
    super.initState();
  }

  Future<void> _navigatePictureUpload(BuildContext context) async {
    // final result = await Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const PictureUpload()));
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

    return ResponsiveLayoutController(
      mobile: Column(
        children: [
          // GestureDetector(
          //   onTap: () => _navigatePictureUpload(context),
          //   child:
          Container(
            margin: marginDefined,
            padding: paddingDefined,
            // color: Colors.red,
            height: size.height * 0.3,
            width: size.width * 1,
            decoration: inputDecorationDefined(context),
            child: Stack(
              children: [
                _pictures!.isEmpty
                    ? const Center(child: Text("Tiada Gambar"))
                    : ListView.builder(
                        itemCount: _pictures!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image(
                              // width: size.width * 1,
                              image: FileImage(
                            _pictures![index],
                          ));
                        }),
                Positioned(
                  // top: 0,
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () => _navigatePictureUpload(context),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
          // ),
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

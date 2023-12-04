import 'package:flutter/material.dart';
import 'package:fyp_project/models/user_model.dart';
import 'package:fyp_project/providers/profile_provider.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/all_text_fields.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/ic_image.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Verification extends StatefulWidget {
  static const routeName = "/verification";

  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late Map<String, dynamic> args;
  bool _isInit = true;

  //communityAt
  final districtController = TextEditingController(text: "Kinta");
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final subDistrictController = TextEditingController(text: "Ipoh");

  //identificationImage
  File? frontIC;
  File? backIC;

  //the rest
  final identificationNoController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> takePicture(bool isFront) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
    );

    if (imageFile == null) {
      return;
    }

    if (isFront) {
      setState(() {
        frontIC = File(imageFile.path);
      });
    } else {
      setState(() {
        backIC = File(imageFile.path);
      });
    }
  }

  void removePicture(bool isFront) {
    if (isFront) {
      setState(() {
        frontIC = null;
      });
    } else {
      setState(() {
        backIC = null;
      });
    }
  }

  void showPopUp(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog(context, title, content);
      },
    );
  }

  AlertDialog alertDialog(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void sendForm() {
    if (backIC == null || frontIC == null) {
      showPopUp("Ralat", "Gambar tidak lagi di import");
    }

    final userModel = UserModel(
      communityAt: {
        'district': districtController.text,
        'place': addressController.text,
        'postcode': postcodeController.text,
        'subDistrict': subDistrictController.text,
      },
      identificationImage: {
        'back': backIC as File,
        'front': frontIC as File,
      },
      identificationNo: identificationNoController.text,
      name: nameController.text,
      authUID: args['authUID'],
    );

    if (userModel.identificationNo == "" ||
        userModel.communityAt["postcode"] == "" ||
        userModel.communityAt["place"] == "" ||
        userModel.name == "") {
      showPopUp("Ralat", "Terdapat maklumat yang tidak lengkap");
    } else {
      ProfileProvider().updateProfile(
        userModel,
        context,
        args['userUID'],
      );
      Navigator.of(context).pop();
    }
  }

  void handlePicLoad(Map<String, dynamic> images) async {
    final tempDir = await getTemporaryDirectory();

    final backPic = images['back'];
    final frontPic = images['front'];

    final backBytes = await http.get(Uri.parse(backPic));
    backIC = await File('${tempDir.path}/back.png').create();

    final frontBytes = await http.get(Uri.parse(frontPic));
    frontIC = await File('${tempDir.path}/front.png').create();

    setState(() {
      backIC!.writeAsBytesSync(backBytes.bodyBytes);
      frontIC!.writeAsBytesSync(frontBytes.bodyBytes);
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      if (args['identificationNo'] == "") {
        return;
      } else {
        nameController.text = args['name'];
        identificationNoController.text = args['identificationNo'];
        addressController.text = args['communityAt']['place'];
        districtController.text = args['communityAt']['district'];
        postcodeController.text = args['communityAt']['postcode'];
        subDistrictController.text = args['communityAt']['subDistrict'];

        handlePicLoad(args['identificationImage']);
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    identificationNoController.dispose();
    addressController.dispose();
    districtController.dispose();
    postcodeController.dispose();
    subDistrictController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        imageCache.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kemaskini Profil"),
        ),
        body: SizedBox(
          height: size.height * 1,
          width: size.width * 1,
          child: ResponsiveLayoutController(
            mobile: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 1,
                    height: size.height * 0.35,
                    child: ICimage(
                      frontIC: frontIC,
                      backIC: backIC,
                      takePicture: takePicture,
                      removePicture: removePicture,
                    ),
                  ),
                  AllTextFields(
                    nameController: nameController,
                    identificationNoController: identificationNoController,
                    districtController: districtController,
                    addressController: addressController,
                    postcodeController: postcodeController,
                    subDistrictController: subDistrictController,
                    isHide: args['identificationNo'] == "",
                  ),
                  BottomBar(
                    sendForm: sendForm,
                  ),
                ],
              ),
            ),
            tablet: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: ICimage(
                      frontIC: frontIC,
                      backIC: backIC,
                      takePicture: takePicture,
                      removePicture: removePicture,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AllTextFields(
                          nameController: nameController,
                          identificationNoController:
                              identificationNoController,
                          districtController: districtController,
                          addressController: addressController,
                          postcodeController: postcodeController,
                          subDistrictController: subDistrictController,
                          isHide: args['identificationNo'] == "",
                        ),
                        BottomBar(
                          sendForm: sendForm,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

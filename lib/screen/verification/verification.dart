import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'widgets/all_text_fields.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/ic_image.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  // bool showSignUp = true;

  File? frontIC;
  File? backIC;
  final positionController = TextEditingController();
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  // void takePicture(bool isFront, bool isCamera) {
  //   _takePicture(isFront, isCamera);
  // }

  // void removePicture(bool isFront) {
  //   _removePicture(isFront);
  // }

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

  void sendForm() {
    //fireabase sent stuff
  }

  // void negateShowSignUp() {
  //   setState(() {
  //     showSignUp = !showSignUp;
  //   });
  // }

  @override
  void dispose() {
    positionController.dispose();
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar:
          // showSignUp
          //     ?
          AppBar(
        title: const Text("Sign Up"),
      ),
      // : AppBar(
      //     title: const Text("Login"),
      //     leading: IconButton(
      //       onPressed: negateShowSignUp,
      //       icon: const Icon(Icons.keyboard_return),
      //     ),
      //   ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child:
            //  showSignUp
            //     ?
            ResponsiveLayoutController(
          mobile: Column(
            children: [
              ICimage(
                mediaQuery: mediaQuery,
                paddingTop: paddingTop,
                frontIC: frontIC,
                backIC: backIC,
                takePicture: takePicture,
                removePicture: removePicture,
              ),
              AllTextFields(
                mediaQuery: mediaQuery,
                paddingTop: paddingTop,
                positionController: positionController,
                nameController: nameController,
                addressController: addressController,
              ),
              BottomBar(
                mediaQuery: mediaQuery,
                paddingTop: paddingTop,
                sendForm: sendForm,
              ),
            ],
          ),
          tablet: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ICimage(
                    mediaQuery: mediaQuery,
                    paddingTop: paddingTop,
                    frontIC: frontIC,
                    backIC: backIC,
                    takePicture: takePicture,
                    removePicture: removePicture,
                  ),
                  AllTextFields(
                    mediaQuery: mediaQuery,
                    paddingTop: paddingTop,
                    positionController: positionController,
                    nameController: nameController,
                    addressController: addressController,
                  ),
                ],
              ),
              BottomBar(
                mediaQuery: mediaQuery,
                paddingTop: paddingTop,
                sendForm: sendForm,
              ),
            ],
          ),
        ),
        // : Container(),
      ),
    );
  }
}

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
  // bool showSignUp = true;

  late Map<String, dynamic> args;
  bool _isInit = true;

  //communityAt
  final districtController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final subDistrictController = TextEditingController();

  //identificationImage
  File? frontIC;
  File? backIC;

  //the rest
  final identificationNoController = TextEditingController();
  final nameController = TextEditingController();

  // final positionController = TextEditingController(); //?

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
    //define shape of the usermodel and send

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

    //send it
    ProfileProvider().updateProfile(
      userModel,
      context,
      args['userUID'],
    );
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

    // final String frontUrl = args['identificationImage']['front'];
    // final String backUrl = args['identificationImage']['back'];

    // final frontBytes = await http.get(Uri.parse(frontUrl));
    // final backBytes = await http.get(Uri.parse(backUrl));

    // final tempDir = await getTemporaryDirectory();
    // backIC = await File('${tempDir.path}/image.png').create();

    // setState(() {
    //   backIC!.writeAsBytesSync(backBytes.bodyBytes);
    //   frontIC!.writeAsBytesSync(frontBytes.bodyBytes);
    // });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      // print(args); {communityAt: {district: , postcode: , place: , subDistrict: },
      //identificationImage: {back: , front: }, name: , identificationNo: ,
      //authUID: SudrkEySEkYUTHFF1K54M7EtoIf2, userUID: WYYOI3s27VC5QART82ns}

      if (args['identificationNo'] == "") {
        return;
      } else {
        nameController.text = args['name'];
        identificationNoController.text = args['identificationNo'];
        addressController.text = args['communityAt']['place'];
        districtController.text = args['communityAt']['district'];
        postcodeController.text = args['communityAt']['postcode'];
        subDistrictController.text = args['communityAt']['subDistrict'];

        //supposedly for picture buh in file

        handlePicLoad(args['identificationImage']);
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // positionController.dispose();
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
    final mediaQuery = MediaQuery.of(context);

    //accept the context, of well the items

    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return WillPopScope(
      onWillPop: () async {
        // _deleteCacheDir();
        imageCache.clear();
        return true;
      },
      child: Scaffold(
        appBar:
            // showSignUp
            //     ?
            AppBar(
          title: const Text("Update Profile"),
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
                  // positionController: positionController,
                  nameController: nameController,
                  identificationNoController: identificationNoController,
                  districtController: districtController,
                  addressController: addressController,
                  postcodeController: postcodeController,
                  subDistrictController: subDistrictController,
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
                    //here just check jr if image tu ada if yes view je and buat utton yg leh change image
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
                      // positionController: positionController,
                      nameController: nameController,
                      identificationNoController: identificationNoController,
                      districtController: districtController,
                      addressController: addressController,
                      postcodeController: postcodeController,
                      subDistrictController: subDistrictController,
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
      ),
    );
  }
}

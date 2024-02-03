import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/models/message_model.dart';
import 'package:fyp_project/screen/chat/widgets/chat_area.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:fyp_project/screen/chat/widgets/text_entered.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../help_form/widgets/camera/picture_upload.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  static const routeName = "/chat";

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController chatText = TextEditingController();
  bool callsPicked = false;
  List<File>? pictures = [];
  LocationData? currentLocation;
  bool option = false;

  void getCurrentLocation() async {
    if (mounted) {
      Location location = Location();
      location.getLocation().then((location) {
        setState(() {
          currentLocation = location;
        });
      });
    }
  }

  void callsHasBeenPicked() {
    setState(() {
      callsPicked = true;
    });
  }

  void sendLocation(
    String requestID,
  ) async {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final response = await http.get(
      Uri.parse(
          "https://api.geoapify.com/v1/geocode/reverse?lat=${currentLocation!.latitude!}&lon=${currentLocation!.longitude!}&apiKey=$reverseGeoApiKey"),
    );
    final json = jsonDecode(response.body);
    String message = json["features"][0]["properties"]["formatted"].toString();

    final messageModel = MessageModel(
      requestID: requestID,
      uid: authUID,
      message: message,
      currentLocation: GeoPoint(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
      ),
    );

    if (context.mounted) {
      Provider.of<ChatProvider>(context, listen: false)
          .addMessage(messageModel);
    }

    if (currentLocation != null) {
      setState(() {
        currentLocation = null;
      });
    }
  }

  void sendMessage(
    String requestID,
    String message,
    List<File>? picture,
  ) {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    final messageModel = MessageModel(
      requestID: requestID,
      uid: authUID,
      message: message,
      picture: picture,
    );

    //send to provider
    Provider.of<ChatProvider>(context, listen: false).addMessage(messageModel);

    //check picture empty or not
    if (pictures!.isNotEmpty) {
      setState(() {
        pictures = [];
      });
    }

    //clear chat
    chatText.clear();
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

  void _removePicture(int index) {
    setState(() {
      pictures = pictures!..removeAt(index);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * here we need to first do a function and have like loading
     * screen before proceeding, in that we check by shift, I think?
     * let's say person a,b,c,d -> a has been occupied or has more shift
     * then the rest, so go to b and so on..
     */

    Size size = MediaQuery.of(context).size;
    // final mediaQuery = MediaQuery.of(context);

    final arguments = ModalRoute.of(context)!.settings.arguments as String;

    var appBar2 = AppBar(
      title: const Text("Pertanyaan dan Kecemasan").animate().fade().slide(),
    );

    // final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChatProvider>(context, listen: false)
            .deleteAssistanceRequest();
        return true;
      },
      child: Scaffold(
        //if keluar, fire some function that delete that request
        appBar: appBar2,
        body: Column(
          children: [
            Expanded(
              child: ChatArea(
                arguments: arguments,
                callsHasBeenPicked: callsHasBeenPicked,
              ),
            ),
            option == true || pictures!.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 50,
                      child: option == false || pictures!.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: pictures!.length ?? 0,
                              itemBuilder: (context, index) {
                                if (pictures!.isNotEmpty) {
                                  return SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: GestureDetector(
                                      onLongPress: () {
                                        _removePicture(index);
                                      },
                                      child: Image.file(pictures![index]),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })
                          : Row(
                              children: [
                                Row(
                                  children: [
                                    IconButton.filledTonal(
                                      onPressed: () =>
                                          navigatePictureUpload(context),
                                      icon: const Icon(Icons.photo),
                                    ),
                                    const Text("Gallery"),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    IconButton.filledTonal(
                                      onPressed: () => sendLocation(arguments),
                                      icon: const Icon(Icons.map),
                                    ),
                                    const Text("Location"),
                                  ],
                                ),
                              ],
                            ),
                    ).animate().fade(),
                  )
                : Container().animate().fade(),
            //here textfield
            callsPicked
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextEntered(chatText: chatText),
                      IconButton.filledTonal(
                        onPressed: () {
                          setState(() {
                            option = !option;
                          });
                        },
                        icon: const Icon(Icons.add_box_outlined),
                      ),
                      IconButton.filledTonal(
                        onPressed: () => sendMessage(
                          arguments,
                          chatText.text,
                          pictures,
                        ), //here should hntr file image
                        icon: const Icon(Icons.send),
                      )
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

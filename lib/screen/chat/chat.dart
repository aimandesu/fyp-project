import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/models/message_model.dart';
import 'package:fyp_project/screen/chat/widgets/chat_area.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:fyp_project/screen/chat/widgets/text_entered.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static const routeName = "/chat";

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController chatText = TextEditingController();
  bool callsPicked = false;
  late Stream<bool> theStream;

  void callsHasBeenPicked(){
    setState(() {
      callsPicked = true;
    });
  }

  Stream<bool> hasPicked() async* {
    final authUID = FirebaseAuth.instance.currentUser!.uid;

    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("authUID", isEqualTo: authUID)
        .snapshots()
        .map((doc) =>
            doc.docs.first.data()['assistanceID'] != "" &&
            doc.docs.first.data()['isPicked'] != false);
  }

  void sendMessage(
    String requestID,
    String message,
    File? picture,
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
  }

  @override
  void initState() {
    theStream = hasPicked();
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

    // Size size = MediaQuery.of(context).size;
    // final mediaQuery = MediaQuery.of(context);

    final arguments = ModalRoute.of(context)!.settings.arguments as String;

    var appBar2 = AppBar(
      title: const Text("Pertanyaan").animate().fade().slide(),
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
            //here textfield
            callsPicked ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextEntered(chatText: chatText),
                IconButton.filledTonal(
                  onPressed: () => sendMessage(
                    arguments,
                    chatText.text,
                    null,
                  ), //here should hntr file image
                  icon: const Icon(Icons.send),
                )
              ],
            ) : Container(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

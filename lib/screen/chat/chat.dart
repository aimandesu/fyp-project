import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/screen/chat/widgets/chat_area.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:fyp_project/screen/chat/widgets/textEntered.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  static const routeName = "/chat";

  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController chatText = TextEditingController();

  Stream<bool> hasPicked() async* {
    final userUID = FirebaseAuth.instance.currentUser!.uid;

    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("userUID", isEqualTo: userUID)
        .snapshots()
        .map((doc) =>
            doc.docs.first.data()['assistanceID'] != "" &&
            doc.docs.first.data()['isPicked'] != false);
  }

  late Stream<bool> theStream;

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

    var appBar2 = AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Assistance"),
    );

    // final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      //if keluar, fire some function that delete that request
      appBar: appBar2,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<bool>(
              stream: theStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                bool hasPicked = snapshot.data ?? false;

                if (hasPicked) {
                  return const ChatArea(); //here just shows the text yg will occur
                } else {
                  return const Text('Awaiting for your calls to be picked');
                }
              },
            ),
          ),
          //here textfield
          TextEntered(chatText: chatText)
        ],
      ),
    );
  }
}

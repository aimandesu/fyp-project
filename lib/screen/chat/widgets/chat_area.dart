import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/chat/widgets/bubble.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat_provider.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({
    super.key,
  });

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  /*
   for this part, we need this kind of logic, where
   there will be assistance class, which has bool -> to detect whether
   this person has been occupied or not, and well some logic to
   check how many shift the person has gone through
   */

  String requestID = "";

  void getRequestID() async {
    //get the id of chat

    final String id =
        await Provider.of<ChatProvider>(context, listen: false).getRequestID();
    setState(() {
      requestID = id;
    });
  }

  @override
  void didChangeDependencies() {
    getRequestID();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryContainer;
    double circular = 25;
    if (requestID != "") {
      return StreamBuilder(
          stream: Provider.of<ChatProvider>(context, listen: false)
              .fetchChat(requestID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.hasData) {
              final authUID = FirebaseAuth.instance.currentUser!.uid;

              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    String text = snapshot.data![index]['text'];
                    String uid = snapshot.data![index]['uid'];
                    return

                      Bubble(
                      message: text,
                      isUser: uid == authUID,
                    );

                    // Container(
                    // margin: marginDefined,
                    // child: Card(
                    //   color: uid == userUID ? Colors.red : Colors.green,
                    //   child: Text(text),
                    // ),
                    // );
                  });
            } else {
              return const Text("some error occurred");
            }
          });
    } else {
      return Container();
    }
  }
}

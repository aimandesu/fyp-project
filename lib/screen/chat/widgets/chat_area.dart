import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/screen/chat/widgets/bubble.dart';
import 'package:provider/provider.dart';
import '../../../providers/chat_provider.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({
    super.key,
    required this.arguments,
    required this.callsHasBeenPicked,
  });

  final String arguments;
  final VoidCallback callsHasBeenPicked;

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  late Stream<List<Map<String, dynamic>>> chatStream;

  /*
   for this part, we need this kind of logic, where
   there will be assistance class, which has bool -> to detect whether
   this person has been occupied or not, and well some logic to
   check how many shift the person has gone through
   */

  @override
  void initState() {
    chatStream = Provider.of<ChatProvider>(context, listen: false)
        .fetchChat(widget.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.hasData) {
          final authUID = FirebaseAuth.instance.currentUser!.uid;

          if (snapshot.data!.isEmpty) {
            return const Text("sedang menunggu pangilan diangkat");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.callsHasBeenPicked();
            });

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                String text = snapshot.data![index]['text'];
                String uid = snapshot.data![index]['uid'];
                List<dynamic>? picture = snapshot.data![index]['picture'];
                return Bubble(
                  message: text,
                  isUser: uid == authUID,
                  picture: picture,
                );
              },
            );
          }
        } else {
          return const Text("some error occurred");
        }
      },
    );
  }
}

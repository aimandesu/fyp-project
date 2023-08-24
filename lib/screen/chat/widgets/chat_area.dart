import 'package:flutter/material.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key});

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

  @override
  Widget build(BuildContext context) {
    return const Text("this is chat area");
  }
}

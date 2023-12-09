import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/admin/assistance/widgets/chat_place.dart';
import 'package:fyp_project/admin/assistance/widgets/list_need_assistance.dart';
import 'package:fyp_project/admin/providers/assistance_provider.dart';
import 'package:provider/provider.dart';
import '../../models/message_model.dart';
import '../../providers/chat_provider.dart';

class Assistance extends StatefulWidget {
  const Assistance({super.key});

  @override
  State<Assistance> createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  late Stream<List<Map<String, dynamic>>> callStream;
  late Stream? chatStream;
  bool triggerOption = false;

  bool customTileExpanded = false;
  String? callsOn;

  final TextEditingController chatText = TextEditingController();

  @override
  void initState() {
    callStream = AssistanceProvider().pickCalls();
    chatStream = null;
    super.initState();
  }

  void changeOption() {
    setState(() {
      triggerOption = !triggerOption;
    });
  }

  void resetChat() {
    setState(() {
      callsOn = null;
    });
  }

  void expandTile(bool expanded) {
    setState(() {
      customTileExpanded = expanded;
    });
  }

  void changeChannelMessage(String requestID) {
    setState(() {
      callsOn = requestID;
      AssistanceProvider().targetMessage(callsOn.toString());
      chatStream = Provider.of<ChatProvider>(context, listen: false)
          .fetchChat(callsOn.toString());
    });
  }

  void sendMessage(
    String requestID,
    String message,
  ) {
    String authUID = "dev";

    final messageModel = MessageModel(
      requestID: requestID,
      uid: authUID,
      message: message,
    );

    //send to provider
    Provider.of<ChatProvider>(context, listen: false).addMessage(messageModel);

    //clear text chat
    chatText.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // there are other calls but once you pick a call to deal with, close the othr calls from seeing

    return Row(
      children: [
        ListNeedAssistance(
          callStream: callStream,
          changeChannelMessage: changeChannelMessage,
          expandTile: expandTile,
        ),
        ChatPlace(
          callsOn: callsOn,
          chatStream: chatStream,
          triggerOption: triggerOption,
          chatText: chatText,
          changeOption: changeOption,
          sendMessage: sendMessage,
          resetChat: resetChat,
        )
      ],
    );
  }
}

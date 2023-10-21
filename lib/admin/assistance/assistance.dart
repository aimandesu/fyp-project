import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/admin/providers/assistance_provider.dart';
import 'package:fyp_project/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';
import '../../screen/chat/widgets/bubble.dart';
import '../../screen/chat/widgets/text_entered.dart';

class Assistance extends StatefulWidget {
  const Assistance({super.key});

  @override
  State<Assistance> createState() => _AssistanceState();
}

class _AssistanceState extends State<Assistance> {
  late Stream callStream;
  late Stream chatStream;
  bool triggerOption = false;

  bool customTileExpanded = false;
  String? callsOn;

  final TextEditingController chatText = TextEditingController();

  @override
  void initState() {
    callStream = AssistanceProvider().pickCalls();
    super.initState();
  }

  void sendMessage() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // there are other calls but once you pick a call to deal with, close the othr calls from seeing

    return Row(
      children: [
        Container(
          width: 250,
          height: size.height * 1,
          decoration: decorationDefined(
              Theme.of(context).colorScheme.primaryContainer, 35),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: marginDefined,
          child: StreamBuilder(
              stream: callStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          // expandedAlignment: Alignment.centerLeft,
                          expandedCrossAxisAlignment: CrossAxisAlignment.end,
                          title: Text(snapshot.data![index]["requestID"]),
                          children: [
                            const Text("Proceed to messaging"),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  callsOn = snapshot.data![index]["requestID"];
                                  chatStream = Provider.of<ChatProvider>(
                                          context,
                                          listen: false)
                                      .fetchChat(callsOn.toString());
                                  //refresh the stream
                                });
                              },
                              child: const Text("Proceed"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                          onExpansionChanged: (bool expanded) {
                            setState(() {
                              customTileExpanded = expanded;
                            });
                          },
                        ),
                      );
                    },
                  );
                }
              }),
        ),
        Expanded(
          child: callsOn == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/chat.json"),
                    const Text(
                      "Helping people is a good deed. Have a nice day!",
                      style: textStyling,
                    )
                  ],
                )
              : Stack(
                  children: [
                    StreamBuilder(
                      stream: chatStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.hasData) {
                          const String authUID = "dev";

                          return SizedBox(
                            width: size.width * 0.7,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) {
                                String text = snapshot.data![index]['text'];
                                String uid = snapshot.data![index]['uid'];
                                return Bubble(
                                  message: text,
                                  isUser: uid == authUID,
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text("some error occurred");
                        }
                      },
                    ),
                    triggerOption
                        ? Positioned(
                            bottom: 50,
                            right: 0,
                            child: Container(
                                margin: marginDefined,
                                height: 50,
                                width: 90,
                                decoration: decorationDefined(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    20)),
                          ).animate().fade().slideY(curve: Curves.easeIn)
                        : Container(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: TextEntered(chatText: chatText)),
                            IconButton.filledTonal(
                              onPressed: () {
                                setState(() {
                                  triggerOption = !triggerOption;
                                });
                              },
                              icon: const Icon(Icons.browse_gallery),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton.filledTonal(
                              onPressed: sendMessage,
                              icon: const Icon(Icons.send),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
        ),
      ],
    );
  }
}

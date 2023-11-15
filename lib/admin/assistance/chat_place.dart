import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fyp_project/admin/providers/assistance_provider.dart';
import 'package:lottie/lottie.dart';

import '../../constant.dart';
import '../../screen/chat/widgets/bubble.dart';
import '../../screen/chat/widgets/text_entered.dart';

class ChatPlace extends StatelessWidget {
  const ChatPlace({
    super.key,
    required this.callsOn,
    required this.chatStream,
    required this.triggerOption,
    required this.chatText,
    required this.changeOption,
    required this.sendMessage,
  });

  final String? callsOn;
  final Stream<dynamic>? chatStream;
  final bool triggerOption;
  final TextEditingController chatText;
  final VoidCallback changeOption;
  final void Function(
    String requestID,
    String message,
    File? picture,
  ) sendMessage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Expanded(
      child: callsOn == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/help.json", repeat: false),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                            String? picture = snapshot.data[index]['picture'];

                            if (text == "exit") {
                              return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      decoration: decorationDefinedShadow(
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          35),
                                      child: Column(
                                        children: [
                                          const Text("User has left the chat"),
                                          OutlinedButton(
                                            onPressed: () =>
                                                AssistanceProvider()
                                                    .endChat(callsOn!),
                                            child: const Text("Kill chat"),
                                          )
                                        ],
                                      )));
                            } else {
                              return Bubble(
                                message: text,
                                isUser: uid == authUID,
                                picture: picture,
                              );
                            }
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
                                Theme.of(context).colorScheme.primaryContainer,
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
                          onPressed: () => changeOption(),
                          icon: const Icon(Icons.browse_gallery),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton.filledTonal(
                          onPressed: () => sendMessage(
                            callsOn.toString(),
                            chatText.text,
                            null,
                          ),
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
    );
  }
}

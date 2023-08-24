import 'package:flutter/material.dart';
import 'package:fyp_project/chat/widgets/chat_area.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  static const routeName = "/chat";
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    /**
     * here we need to first do a function and have like loading
     * screen before proceeding, in that we check by shift, I think?
     * let's say person a,b,c,d -> a has been occupied or has more shift 
     * then the rest, so go to b and so on..
     */

    Size size = MediaQuery.of(context).size;
    final mediaQuery = MediaQuery.of(context);
    Color color = Theme.of(context).colorScheme.primary;
    double circular = 25;

    var appBar2 = AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Assistance"),
    );

    TextEditingController chatText = TextEditingController();
    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar2,
      body: StreamBuilder<bool>(
        stream: Provider.of<ChatProvider>(context).hasPicked(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          bool hasPicked = snapshot.data ?? false;

          if (hasPicked) {
            return Column(
              children: [
                Container(
                  width: 100,
                  height: 30,
                  decoration: decorationDefined(color, circular),
                  child: const Text("Assistance"),
                ),
                SizedBox(
                  height: size.height * 0.8,
                  child: const ChatArea(),
                ),
                Container(
                  margin: marginDefined,
                  padding: paddingDefined,
                  decoration: decorationDefined(color, circular),
                  child: TextField(
                    controller: chatText,
                  ),
                ),
              ],
            );
          } else {
            return const Text('Awaiting for your calls to be picked');
          }
        },
      ),
    );
  }
}

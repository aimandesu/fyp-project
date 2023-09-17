import 'package:flutter/material.dart';
import 'package:fyp_project/providers/support_result_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../providers/chat_provider.dart';
import '../../chat/chat.dart';

class SupportResult extends StatelessWidget {
  static const routeName = "/support-result";

  const SupportResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Provider.of<SupportResultProvider>(context, listen: false)
            .getResult(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const Text(
              "Wait, your application is in approval process",
              style: textStyling,
            );
          } else if (snapshot.data == true) {
            return const Text(
              "No new request for approval",
              style: textStyling,
            );
          }else{
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChatProvider.askAssistance();
          Navigator.pushNamed(context, Chat.routeName);
        },
        child: const Icon(
          Icons.support_agent,
        ),
      ),
    );
  }
}

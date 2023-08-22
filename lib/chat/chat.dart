import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';

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

    Color color = Theme.of(context).colorScheme.primary;
    double circular = 25;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Assistance"),
      ),
      body: Column(
        children: [
          Container(
            width: 100,
            height: 30,
            decoration: decorationDefined(color, circular),
            child: const Text("Assistance"),
          )
        ],
      ),
    );
  }
}

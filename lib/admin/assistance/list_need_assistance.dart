import 'package:flutter/material.dart';

import '../../constant.dart';

class ListNeedAssistance extends StatelessWidget {
   ListNeedAssistance({
    super.key,
    required this.callStream,
    required this.changeChannelMessage,
    required this.expandTile,
  });

   Stream<dynamic> callStream;
  final void Function(String) changeChannelMessage;
  final void Function(bool) expandTile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 250,
      height: size.height * 0.8,
      decoration:
          decorationDefinedShadow(Theme.of(context).colorScheme.onPrimary, 35),
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
                        onPressed: () => changeChannelMessage(
                            snapshot.data![index]["requestID"].toString()),
                        child: const Text("Proceed"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      () => expandTile(expanded);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

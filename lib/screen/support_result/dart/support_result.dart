import 'package:flutter/material.dart';
import 'package:fyp_project/providers/support_result_provider.dart';
import 'package:fyp_project/screen/support_result/dart/widgets/result.dart';
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
      appBar: AppBar(
        title: Text("Senarai Kes Dipohon"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Provider.of<SupportResultProvider>(context, listen: false)
            .getAppliedForm(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String caseID = snapshot.data![index]['caseID'];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Result.routeName, arguments: caseID);
                  },
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(snapshot.data![index]['caseID']),
                  ),
                );
              },
            );
          } else {
            return Container();
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

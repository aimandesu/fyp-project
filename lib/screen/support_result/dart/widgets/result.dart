import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../providers/support_result_provider.dart';
import '../../../chat/chat.dart';
import 'result_container.dart';

class Result extends StatelessWidget {
  static const routeName = "/result";

  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final String caseID = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Semakan Menunggu"),
      ),
      body: FutureBuilder(
        future: Provider.of<SupportResultProvider>(context, listen: false)
            .getResult(caseID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if (snapshot.data!['reviewed'] == false) {
            return ResultContainer(
              kesID: snapshot.data!['caseID'].toString(),
              nama: snapshot.data!['name'].toString(),
              noPhone: snapshot.data!['phone'].toString(),
              noKadPengenalan: snapshot.data!['noIC'].toString(),
              message: '',
              approval: null,
            );
          } else if (snapshot.data!['reviewed'] == true) {
            return ResultContainer(
              kesID: snapshot.data!['caseID'].toString(),
              nama: snapshot.data!['name'].toString(),
              noPhone: snapshot.data!['phone'].toString(),
              noKadPengenalan: snapshot.data!['noIC'].toString(),
              message: 'message diterima or whatnot',
              approval: snapshot.data!['approved'],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

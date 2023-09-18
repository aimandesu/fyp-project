import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant.dart';
import '../../../../providers/chat_provider.dart';
import '../../../../providers/support_result_provider.dart';
import '../../../chat/chat.dart';

class Result extends StatelessWidget {
  static const routeName = "/result";

  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final String caseID  = ModalRoute.of(context)!.settings.arguments as String;

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
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: size.height * 0.7,
                width: size.width * 0.9,
                decoration: decorationDefinedShadow(
                    Theme.of(context).colorScheme.primaryContainer, 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: marginDefined,
                      child: Text( "Kes ID: ${snapshot.data!['caseID']}"),
                    ),
                    Container(
                      height: size.height * 0.4,
                      width: size.width * 0.9,
                      margin: marginDefined,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama: ${snapshot.data!['name'].toString()}"),
                          Text("No Phone: ${snapshot.data!['phone'].toString()}"),
                          Text("No Kad Pengenalan: ${snapshot.data!['noIC'].toString()}"),
                        ],
                      ),
                    ),
                    Container(
                      margin: marginDefined,
                      child: const Text(
                        "Harap maklum, maklumat dan kes anda sedang disiasat. Maklum balas akan disampaikan apabila sudah selesai",
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.data!['reviewed'] == true) {
            //
            // if(snapshot.data!['approved'] == false){
            //   return const Text("approved");
            // }
            //
            // else{
            //   return const Text("approved");
            // }

            return const Text(
              "Request No",
              style: textStyling,
            );
          } else {
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

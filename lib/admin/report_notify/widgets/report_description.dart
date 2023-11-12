import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../constant.dart';

class ReportDescription extends StatelessWidget {
  const ReportDescription({super.key, required this.formToRender});

  final Map<String, dynamic>? formToRender;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: formToRender == null
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
          : Column(
        children: [
          //should be disaster then picture
          Text(formToRender!["disaster"][0]),
          Text(formToRender!["userUID"]),
        ],
      ),
    );
  }
}

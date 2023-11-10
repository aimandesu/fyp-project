import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportNotify extends StatefulWidget {
  const ReportNotify({super.key});

  @override
  State<ReportNotify> createState() => _ReportNotifyState();
}

class _ReportNotifyState extends State<ReportNotify> {
  
  void testFCM() async {
    final response = await http.get(Uri.parse("http://localhost:3000/api/fcm"));
    // final json = jsonDecode(response.body);
    // print(json);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Where report comes from"),
        Container(
          child: Text("Where we going to notify people"),
        ),
        ElevatedButton(
          onPressed: () {
            testFCM();
          },
          child: const Text("Send message"),
        )
      ],
    );
  }
}

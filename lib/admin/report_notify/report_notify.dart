import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_project/admin/report_notify/widgets/list_report.dart';
import 'package:fyp_project/admin/report_notify/widgets/notify_people.dart';
import 'package:fyp_project/admin/report_notify/widgets/report_description.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../constant.dart';
import '../providers/form_provider.dart';

class ReportNotify extends StatefulWidget {
  const ReportNotify({super.key});

  @override
  State<ReportNotify> createState() => _ReportNotifyState();
}

class _ReportNotifyState extends State<ReportNotify> {
  late Future<List<Map<String, dynamic>>> reportIncidence;
  String? reportOn;
  Map<String, dynamic>? formToRender;

  //notification
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  void changeReportOn(
    String reportID,
    Map<String, dynamic> reportForm,
  ) {
    setState(() {
      reportOn = reportID;
      formToRender = reportForm;
    });
  }

  void sendNotification(Map<String, dynamic> message) async {

    if(message['title'] == "" || message['body'] == "") {
      showDialog(
        context: context, // You'll need a BuildContext to show a dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("One or more fields are empty."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }else{
      //way to pass
      // final response = await http.get(Uri.parse("http://localhost:3000/api/fcm"));
      // final json = jsonDecode(response.body);
      // print(json);
      print(message['district']);
      print(message['title']);
      print(message['body']);
    }
  }

  @override
  void initState() {
    reportIncidence = FormProvider().pickReports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        // ListReport(
        //   reportIncidence: reportIncidence,
        //   reportOn: reportOn,
        //   changeReportOn: changeReportOn,
        // ),
        ReportDescription(
          formToRender: formToRender,
        ),
        Container(
          width: size.width * 0.25,
          height: size.height * 0.5,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
            Theme.of(context).colorScheme.onPrimary,
            25,
          ),
          child: NotifyPeople(
            sendNotification: sendNotification,
            title: title,
            body: body,
          ),
        ),
      ],
    );
  }
}

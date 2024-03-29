import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/news_provider.dart';
import 'package:fyp_project/admin/report_notify/widgets/list_report.dart';
import 'package:fyp_project/admin/report_notify/widgets/notify_people.dart';
import 'package:fyp_project/admin/report_notify/widgets/report_description.dart';
import 'package:fyp_project/models/admin/notification_model.dart';
import 'package:http/http.dart' as http;
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

  //formatted address
  String address = "";

  //notification
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController place = TextEditingController();

  List<String>? images = [];
  List<GeoPoint>? geoPoints = [];

  List<String> district = districtPlaces;
  List<String> hazard = hazardsList;

  void showPlace(var lat, var long) async {
    final response = await http.get(Uri.parse(
        "https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$long&apiKey=$reverseGeoApiKey"));
    final json = jsonDecode(response.body);
    setState(() {
      address = json["features"][0]["properties"]["formatted"].toString();
    });
  }

  void changeReportOn(
    String reportID,
    Map<String, dynamic> reportForm,
  ) {
    setState(() {
      reportOn = reportID;
      formToRender = reportForm;
    });
    showPlace(
      formToRender!["currentLocation"].latitude,
      formToRender!["currentLocation"].longitude,
    );
  }

  void showPopUp(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog(context, title, content);
      },
    );
  }

  void sendNotification(
    Map<String, dynamic> message,
    String district,
    String currentHazard,
    List<String> images,
    List<GeoPoint> geoPoints,
    DateTime date,
  ) async {
    final List<String> userList;

    date = DateTime(date.year, date.month, date.day);

    if (message['title'] == "" ||
        message['body'] == "" ||
        images.isEmpty ||
        geoPoints.isEmpty) {
      showPopUp("Error", "There appear to be field missing");
    } else {
      //send to database
      final notificationModel = NotificationModel(
        title: message['title'],
        content: message['body'],
        district: district,
        place: place.text,
        images: images,
        geoPoints: geoPoints,
        date: date,
      );
      final Map<String, dynamic> notificationData = notificationModel.toJson();

      String newsID = await NewsProvider().createNews(notificationData);

      //save to dashboard
      // NewsProvider().saveToDashboard(currentHazard, place.text);

      //get tokens, and pass to message for notification
      userList = await FormProvider().getUserAssociated(district);

      //put userTokens
      message.putIfAbsent("userTokens", () => userList);

      List<String> encodedImageLinks = images.map((link) {
        return Uri.encodeComponent(link);
      }).toList();

      //put images
      message.putIfAbsent("images", () => encodedImageLinks);

      message.putIfAbsent("newsID", () => newsID);

      final encodedMessage = Uri.encodeComponent(jsonEncode(message));

      final response = await http
          .get(Uri.parse("http://localhost:3000/api/fcm/$encodedMessage"));

      final json = jsonDecode(response.body);

      if (json == "success") {
        showPopUp("mesej", "alert has been sent");
      }
    }
  }

  AlertDialog alertDialog(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }

  void updateListAgain() {
    reportIncidence = FormProvider().pickReports();
  }

  void removeFormToRender() {
    setState(() {
      formToRender = null;
    });
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
        ListReport(
          reportIncidence: reportIncidence,
          reportOn: reportOn,
          changeReportOn: changeReportOn,
        ),
        ReportDescription(
          formToRender: formToRender,
          address: address,
          updateListAgain: updateListAgain,
          removeFormToRender: removeFormToRender,
        ),
        Container(
          width: size.width * 0.25,
          height: size.height * 1,
          margin: marginDefined,
          decoration: decorationDefinedShadow(
            Theme.of(context).colorScheme.onPrimary,
            25,
          ),
          child: NotifyPeople(
            sendNotification: sendNotification,
            title: title,
            body: body,
            place: place,
            images: images,
            geoPoints: geoPoints,
            district: district,
            hazard: hazard,
          ),
        ),
      ],
    );
  }
}

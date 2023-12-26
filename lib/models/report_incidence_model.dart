import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportIncidenceModel {
  final List<File> pictures;
  final GeoPoint currentLocation;
  final List<String> disaster;
  final String description;
  final String userUID;

  ReportIncidenceModel(
      {required this.pictures,
      required this.currentLocation,
      required this.disaster,
      required this.description,
      required this.userUID});

  Map<String, dynamic> toJson(
    List<String> pictures,
    DateTime date,
  ) =>
      {
        'pictures': pictures,
        'currentLocation': currentLocation,
        'disaster': disaster,
        'description': description,
        'userUID': userUID,
        'reviewed': false,
        'date': date,
      };
}

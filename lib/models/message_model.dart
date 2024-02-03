import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String requestID;
  final String uid;
  final String message;
  final List<File>? picture;
  final GeoPoint? currentLocation;

  MessageModel({
    required this.requestID,
    required this.uid,
    required this.message,
    this.picture,
    this.currentLocation,
  });

  Map<String, dynamic> toJson(
    List<String> picture,
    int index,
    GeoPoint? currentLocation,
  ) {


    if (picture.isEmpty && currentLocation == null) {
      return {
        'index': index,
        'uid': uid,
        'text': message,
      };
    }

    if (picture.isNotEmpty) {
      return {
        'index': index,
        'uid': uid,
        'text': message,
        'picture': picture,
      };
    }

    if (currentLocation != null) {
      return {
        'index': index,
        'uid': uid,
        'text': message,
        'location': currentLocation,
      };
    }

    return {};
  }
}

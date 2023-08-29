//this one is okay for defining the model of the user of the app

import 'dart:io';

class UserModel {
  final Map<String, String> communityAt;
  final Map<String, File>? identificationImage;
  final String identificationNo;
  final String name;
  final String authUID;

  UserModel({
    required this.communityAt,
    required this.identificationImage,
    required this.identificationNo,
    required this.name,
    required this.authUID,
  });

  Map<String, dynamic> toJson(
    Map<String, String> identificationImage,
  ) =>
      {
        'communityAt': communityAt,
        'identificationImage': identificationImage,
        'identificationNo': identificationNo,
        'name': name,
        'authUID': authUID,
      };
}

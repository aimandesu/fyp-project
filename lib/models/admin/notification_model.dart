import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String content;
  final String district;
  final List<String> images;
  final List<GeoPoint> geoPoints;
  final DateTime date;

  //add date here,

  NotificationModel({
    required this.title,
    required this.content,
    required this.district,
    required this.images,
    required this.geoPoints,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "district": district,
        "images": images,
        "geoPoints": geoPoints,
        "date": date,
      };
}

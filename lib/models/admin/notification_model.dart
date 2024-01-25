import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String content;
  final String district;
  final List<String> images;
  final List<GeoPoint> geoPoints;
  final DateTime date;
  final String place;

  NotificationModel({
    required this.title,
    required this.content,
    required this.district,
    required this.images,
    required this.geoPoints,
    required this.date,
    required this.place,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "district": district,
        "place": place,
        "images": images,
        "geoPoints": geoPoints,
        "date": date,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

import '../../main.dart';

class NewsProvider {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final instance = await FirebaseFirestore.instance
        .collection("news")
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    //before passing sort this by date to a new map

    var mapDate = groupBy(instance, (Map obj) => (obj["date"] as Timestamp).toDate())
        .entries
        .map((entry) => {
              "date": entry.key,
              "content": (entry.value).map((item) {
                return {
                  "title": item["title"],
                  "content": item["content"],
                  "district": item["district"],
                  "images": item["images"],
                  "geoPoints": item["geoPoints"],
                };
              }).toList()
            })
        .toList();

    return mapDate;
  }

  Future<void> createNews(
    Map<String, dynamic> notificationData,
  ) async {
    BuildContext context = navigatorKey.currentContext as BuildContext;
    try {
      await FirebaseFirestore.instance.collection("news").add(notificationData);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
      }
    }
  }
}

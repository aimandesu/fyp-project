import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

import '../../main.dart';

class NewsProvider {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final instance = await FirebaseFirestore.instance
        .collection("news")
        .orderBy("date", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    //before passing sort this by date to a new map

    var mapDate =
        groupBy(instance, (Map obj) => (obj["date"] as Timestamp).toDate())
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

  Future<Map<String, dynamic>> fetchTargetNews(String newsID) async {
    final instance = await FirebaseFirestore.instance
        .collection("news")
        .doc(newsID)
        .get()
        .then((value) => value.data());
    return instance as Map<String, dynamic>;
  }

  Future<String> createNews(
    Map<String, dynamic> notificationData,
  ) async {
    String newsID = "";
    BuildContext context = navigatorKey.currentContext as BuildContext;
    try {
      final newsForm = FirebaseFirestore.instance.collection("news");
      await newsForm.add(notificationData).then((value) {
        newsID = value.id;
        newsForm.doc(value.id).update({
          "newsID": newsID,
        });
      });
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
    return newsID;
  }
}

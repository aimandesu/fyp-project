import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import '../../main.dart';

class NewsProvider {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final instance = await FirebaseFirestore.instance
        .collection("news")
        .orderBy("date", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    //before passing sort this by date to a new map

    var mapDate = groupBy(
            instance,
            (Map obj) => (
                  DateFormat.yMMMMd('en_US').format(
                    (obj["date"] as Timestamp).toDate(),
                  ),
                ))
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
                  "date": item["date"],
                  "place": item["place"]
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

  Future<void> saveToDashboard(
    String hazard,
    String place,
  ) async {
    DateTime date = DateTime.now();
    String currentYear = date.year.toString();
    int currentMonth =
        date.month - 1; //-1 because in our database, it starts with 0 = January

    String monthInText = DateFormat("MMMM").format(date).substring(0, 3);
    Map<String, dynamic>? allData;

    final collection = FirebaseFirestore.instance
        .collection("dataset")
        .doc("cases")
        .collection("year")
        .doc(currentYear);

    final detailCollection = collection.collection("details").doc(monthInText);

    collection.get().then((value) async {
      allData = value.data();
      Map dataInCurrentMonth = allData!["data"][currentMonth];

      if (dataInCurrentMonth["numberCases"] == 0) {
        dataInCurrentMonth['hazard'][hazard] = 1;
        dataInCurrentMonth["numberCases"] = 1;

        await collection.update(allData!.cast<Object, Object?>());
      } else {
        if (dataInCurrentMonth["hazard"][hazard] != null) {
          int hazardTarget = dataInCurrentMonth["hazard"][hazard] + 1;
          int casesCount = dataInCurrentMonth["numberCases"] + 1;

          dataInCurrentMonth['hazard'][hazard] = hazardTarget;
          dataInCurrentMonth["numberCases"] = casesCount;

          await collection.update(allData!.cast<Object, Object?>());
        }
      }
    });

    detailCollection.get().then((value) async {
      allData = value.data();

      List<dynamic> mapDataDetails = allData!["hazard"];
      bool found = false;

      for (Map<String, dynamic> element in mapDataDetails) {
        if (element["type"] == hazard) {
          for (Map<String, dynamic> e in element["place"] as List<dynamic>) {
            if (e["name"] == place) {
              e["count"] += 1;
            }
          }
        }
        found = element["type"] == hazard;
      }
      if (found) {
      } else {
        (allData!["hazard"] as List<dynamic>).add({
          "place": [
            {
              "count": 1,
              "name": place,
            }
          ],
          "type": hazard
        });
      }

      await detailCollection.update(allData!.cast<Object, Object?>());
    });
  }
}

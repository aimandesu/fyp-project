import 'dart:developer';

import 'package:fyp_project/dbHelper/constant.dart';
import 'package:fyp_project/models/user_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(UserModel data) async {
    try {
      var result = await userCollection.insertOne(
        data.toJson(),
      );

      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Something wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FormProvider {
  Future<List<Map<String, dynamic>>> pickForms() async {
    final instance = await FirebaseFirestore.instance
        .collection("form")
        // .where("reviewed", isEqualTo: false)
        .orderBy("date", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    return instance;
  }

  //report forms
  Future<List<Map<String, dynamic>>> pickReports() async {
    final instance = await FirebaseFirestore.instance
        .collection("report")
        // .where("reviewed", isEqualTo: false)
        .orderBy("date", descending: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return instance;
  }

  Future<List<String>> getUserAssociated(String district) async {
    List<String> token = [];

    final querySnapshot =
        await FirebaseFirestore.instance.collection("community").get();

    for (var doc in querySnapshot.docs) {
      final communityData = doc.data();
      final communityDistrict = communityData['communityAt']['district'];

      if (communityDistrict == district) {
        token.add(communityData['fcmToken'].toString());
      }
    }

    return token;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FormProvider {
  //help forms
  Future<List<Map<String, dynamic>>> pickForms(bool reviewed) async {
    final instance = await FirebaseFirestore.instance
        .collection("form")
        .where("reviewed", isEqualTo: reviewed)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    return instance;
  }

  //report forms
  Future<List<Map<String, dynamic>>> pickReports() async {
    final instance = await FirebaseFirestore.instance
        .collection("report")
        .where("reviewed", isEqualTo: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return instance;
  }

  //identification list
  Future<List<Map<String, dynamic>>> pickIdentificationList() async {
    final instance = await FirebaseFirestore.instance
        .collection("community")
        .where("verified", isNotEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return instance;
  }

  //for fcm notifications
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

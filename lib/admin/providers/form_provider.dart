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

  Stream<dynamic> getFormCounts() async* {
    yield* FirebaseFirestore.instance.collection("form").snapshots().map(
        (event) => event.docs.map((doc) => doc.data()["reviewed"]).toList());
  }

  void updateHelpForm(String id) async {
    await FirebaseFirestore.instance.collection("form").doc(id).update({
      "reviewed": true,
    });
  }

  //report forms - report notify
  Future<List<Map<String, dynamic>>> pickReports() async {
    final instance = await FirebaseFirestore.instance
        .collection("report")
        .where("reviewed", isEqualTo: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return instance;
  }

  //identification list - identification verify
  Future<List<Map<String, dynamic>>> pickIdentificationList() async {
    final instance = await FirebaseFirestore.instance
        .collection("community")
        .where("verified", isNotEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return instance;
  }

  //for fcm notifications - report notify
  Future<List<String>> getUserAssociated(String district) async {
    List<String> token = [];

    final querySnapshot =
        await FirebaseFirestore.instance.collection("community").get();

    for (var doc in querySnapshot.docs) {
      final communityData = doc.data();
      final communityDistrict = communityData['communityAt']['subDistrict'];

      if (communityDistrict == district) {
        token.add(communityData['fcmToken'].toString());
      }
    }

    return token;
  }
}

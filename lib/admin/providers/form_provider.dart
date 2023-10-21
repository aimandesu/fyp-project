import 'package:cloud_firestore/cloud_firestore.dart';

class FormProvider {
  Future<List<Map<String, dynamic>>> pickForms() async {
    final instance = await FirebaseFirestore.instance
        .collection("form")
        .where("reviewed", isEqualTo: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());

    return instance;
  }
}

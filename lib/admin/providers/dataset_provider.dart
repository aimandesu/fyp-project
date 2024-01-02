import 'package:cloud_firestore/cloud_firestore.dart';

class DatasetProvider {
  Future<dynamic> fetchYear() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection("dataset")
        .doc("cases")
        .collection("year")
        .get();

    return docSnapshot.docs.map((e) => e.data()['year'].toString()).toList();
  }

  Future<List<Map<String, dynamic>>?> fetchChart(String year) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection("dataset")
        .doc("cases")
        .collection("year")
        .doc(year)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null && data.containsKey("data")) {
        return List<Map<String, dynamic>>.from(data["data"]);
      }
    }

    return null;
  }

  Future<List<Map<String, dynamic>>?> fetchDisasterDetails(String year, String month) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection("dataset")
        .doc("cases")
        .collection("year")
        .doc(year)
    .collection("details")
    .doc(month)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null && data.containsKey("hazard")) {
        return List<Map<String, dynamic>>.from(data["hazard"]);
      }
    }

    return null;
  }

  //not in use as of now
  void updateDataset(
    String year,
    String month,
    dynamic newValue,
    String key,
  ) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("dataset")
        .doc("cases")
        .collection("year")
        .doc(year);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data["month"] == month) {
        data[key] = newValue;
        await docRef.set(data);
      }
    }
  }
}

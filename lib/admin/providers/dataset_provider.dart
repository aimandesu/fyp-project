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

  Future<List<Map<String, dynamic>>?> fetchLineChart(String year) async {
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

    return null; // Handle the case when the document doesn't exist or the data is not in the expected format.
  }


}
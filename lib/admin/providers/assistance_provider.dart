import 'package:cloud_firestore/cloud_firestore.dart';

class AssistanceProvider {
  Stream<List<Map<String, dynamic>>> pickCalls() async* {
    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("assistanceID", isEqualTo: "")
        .where("isPicked", isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()).toList());
  }
}

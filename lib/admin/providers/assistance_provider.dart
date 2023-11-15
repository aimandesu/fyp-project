import 'package:cloud_firestore/cloud_firestore.dart';

class AssistanceProvider {
  Stream<List<Map<String, dynamic>>> pickCalls() async* {
    yield* FirebaseFirestore.instance
        .collection("requestAssistance")
        .where("assistanceID", isEqualTo: "")
        .snapshots()
        .map((event) => event.docs.map((doc) => doc.data()).toList());
  }

  void targetMessage(String chatID) async {
    await FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(chatID)
        .update({
      "isPicked": true,
    });
  }

  void endChat(String chatID) async {
    String authUID = "dev";
    await FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(chatID)
        .update({
      "assistanceID": authUID,
    });
  }
}

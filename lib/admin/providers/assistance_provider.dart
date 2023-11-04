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

  void targetMessage(String chatID) async {
    String authUID = "dev";
    await FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(chatID)
        .update({
      "assistanceID": authUID,
      "isPicked": true,
    });

    await FirebaseFirestore.instance
        .collection("requestAssistance")
        .doc(chatID)
        .collection("chat")
        .add({
      'index': 0,
      'uid': authUID,
      'text': "Selamat Datang, Apa yang boleh kami bantu?",
    });
  }
}

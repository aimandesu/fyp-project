import 'dart:io';

class MessageModel {
  final String requestID;
  final String uid;
  final String message;
  final File? picture;

  MessageModel({
    required this.requestID,
    required this.uid,
    required this.message,
    this.picture,
  });

  Map<String, dynamic> toJson(
    String picture,
    int index,
  ) {
    if (picture == "") {
      return {
        'index': index,
        'uid': uid,
        'text': message,
      };
    } else {
      return {'index': index, 'uid': uid, 'text': message, 'picture': picture};
    }
  }
}
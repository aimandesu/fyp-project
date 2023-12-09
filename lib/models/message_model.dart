import 'dart:io';

class MessageModel {
  final String requestID;
  final String uid;
  final String message;
  final List<File>? picture;

  MessageModel({
    required this.requestID,
    required this.uid,
    required this.message,
    this.picture,
  });

  Map<String, dynamic> toJson(
    List<String> picture,
    int index,
  ) {
    if (picture.isEmpty) {
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

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/main.dart';
import 'package:fyp_project/screen/news/widgets/news_content.dart';

class FcmService {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _triggerSnackBar(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      NewsContent.routeName,
      arguments: message,
    );
  }

  void _triggerSnackBar(RemoteMessage message) {
    ScaffoldMessenger.of(navigatorKey.currentContext as BuildContext)
        .showSnackBar(
      SnackBar(
        content: Column(
          children: [
            Text(message.notification!.title.toString()),
            Text(message.notification!.body.toString())
          ],
        ),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: 'View',
          onPressed: () => _handleMessage(message),
        ),
      ),
    );
  }
}

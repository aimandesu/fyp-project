import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/news_provider.dart';

class NewsContent extends StatefulWidget {
  static const routeName = "/news-content";

  const NewsContent({super.key});

  @override
  State<NewsContent> createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> {
  Map<String, dynamic>? toDisplay;
  bool _isInit = true;

  void updateFromNotification(String message) async {
    Map<String, dynamic> data = await NewsProvider().fetchTargetNews(message);
    setState(() {
      toDisplay = data;
    });
    print(toDisplay);
  }

  void updateFromOntap(Map<String, dynamic> message) {
    setState(() {
      toDisplay = message;
    });
    print(toDisplay);
  }

  @override
  void didChangeDependencies() {
    final message = ModalRoute.of(context)!.settings.arguments as dynamic;
    if (_isInit) {
      if (message is RemoteMessage) {
        updateFromNotification(message.data["newsID"]);
      } else {
        updateFromOntap(message);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return toDisplay == null
        ? Container()
        : Column(
            children: [Text(toDisplay!["content"])],
          );
  }
}

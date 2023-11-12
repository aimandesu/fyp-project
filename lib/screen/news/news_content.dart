import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NewsContent extends StatelessWidget {
  static const routeName = "/news-content";

  const NewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    
    final message = ModalRoute.of(context)!.settings.arguments as dynamic;
    
    if(message is RemoteMessage){
      print("yes");
      //do map here we will update message tu with map logic
    }else{
      print("no");
    }
    
    return Column(
      children: [
        Text(message.notification!.title.toString())
      ],
    );
  }
}

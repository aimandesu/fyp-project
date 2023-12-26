import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/news_provider.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/news/widgets/news_map.dart';

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
  }

  void updateFromOnTap(Map<String, dynamic> message) {
    setState(() {
      toDisplay = message;
    });
  }

  @override
  void didChangeDependencies() {
    final message = ModalRoute.of(context)!.settings.arguments as dynamic;
    if (_isInit) {
      if (message is RemoteMessage) {
        updateFromNotification(message.data["newsID"]);
      } else {
        updateFromOnTap(message);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    AppBar appBar2 = AppBar(
      title: Text(toDisplay!["title"]),
    );

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar2,
      body: toDisplay == null
          ? Container()
          : SizedBox(
              width: mediaQuery.size.width * 1,
              height: (mediaQuery.size.height - paddingTop) * 1,
              child: Column(
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * 1,
                    height: (mediaQuery.size.height - paddingTop) * 0.3,
                    child: PageView.builder(
                      itemCount: (toDisplay!["images"] as List).length,
                      itemBuilder: (context, index) {
                        return Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Image.network(
                              toDisplay!["images"][index],
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 7,
                              right: 5,
                              child: Container(
                                  padding: paddingDefined,
                                  decoration: decorationDefined(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    100,
                                  ),
                                  child: Text((index + 1).toString())),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  //images
                  Container(
                    decoration: decorationDefined(
                      Theme.of(context).colorScheme.primaryContainer,
                      25,
                    ),
                    margin: marginDefined,
                    padding: paddingDefined,
                    height: mediaQuery.size.height * 0.25,
                    width: mediaQuery.size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          toDisplay!["district"],
                          style: textStyling20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //this should be some kind of place, sbb we already make it only ipoh lol
                        Text(
                          toDisplay!["content"],
                          style: textStyling17,
                        ),
                      ],
                    ),
                  ),
                  //geopoints
                  NewsMap(geoPoints: toDisplay!["geoPoints"])
                ],
              ),
            ),
    );
  }
}

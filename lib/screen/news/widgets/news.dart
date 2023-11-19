import 'package:flutter/material.dart';
import 'package:fyp_project/admin/providers/news_provider.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future<List<Map<String, dynamic>>> news;

  @override
  void initState() {
    news = NewsProvider().fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              //wrap column here
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  return Column(
                    // initiallyExpanded: true,
                    // trailing: SizedBox.shrink(),
                    // title: ,
                    children: [
                      Text(
                        snapshot.data![index]["date"].toString(),
                      ),
                      ..._buildContent(size, snapshot.data![index]["content"])
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        });
  }

  List<Widget> _buildContent(Size size, List<Map<String, dynamic>> content) {
    return content.map((item) {
      return Container(
        //here on tap
        width: size.width * 1,
        height: ResponsiveLayoutController.isMobile(context)
            ? size.height * 0.15
            : size.height * 0.5,
        margin: marginDefined,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            buildBackHolder(context),
            buildImage(
              context,
              size,
              item["images"][0],
            ),
            //send image here
            buildNewsDetails(
              context,
              size,
              item["title"],
              item["content"],
            )
            //send details here
          ],
        ),
      );
    }).toList();
  }

  Positioned buildNewsDetails(
    BuildContext context,
    Size size,
    String title,
    String content,
  ) {
    return Positioned(
      right: 0,
      child: SizedBox(
        width: ResponsiveLayoutController.isMobile(context)
            ? size.width * 0.5
            : size.width * 0.2,
        height: ResponsiveLayoutController.isMobile(context)
            ? size.height * 0.1
            : size.height * 0.45,
        child: ListTile(
          title: Text(title),
          subtitle: SingleChildScrollView(
            child: Text(
              content,
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildImage(
    BuildContext context,
    Size size,
    String image,
  ) {
    return Positioned(
      top: -10,
      left: 0,
      child: SizedBox(
        height: ResponsiveLayoutController.isMobile(context)
            ? size.height * 0.14
            : size.height * 0.49,
        width: ResponsiveLayoutController.isMobile(context)
            ? size.width * 0.4
            : size.width * 0.27,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          // Image border
          child: SizedBox.fromSize(
            size: const Size.fromRadius(48), // Image radius
            child: Image.network(image, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Container buildBackHolder(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      decoration: decorationDefinedShadow(
        Theme.of(context).colorScheme.primaryContainer,
        25,
      ),
    );
  }
}

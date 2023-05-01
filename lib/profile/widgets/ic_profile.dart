import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

class IcProfile extends StatelessWidget {
  const IcProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final isTablet = ResponsiveLayoutController.isTablet(context);

    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // color: Colors.red,
              width: isTablet ? size.width * 0.6 : size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Front IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Image.network(
                          "https://images.mein-mmo.de/medien/2021/07/ayakatitel.jpg",
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              // color: Colors.blue,
              width: isTablet ? size.width * 0.6 : size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Back IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Image.network(
                          "https://moewalls.com/wp-content/uploads/2022/08/ayaka-genshin-impact-thumb.jpg",
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../responsive_layout_controller.dart';

class ICimage extends StatelessWidget {
  const ICimage({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);

    return SizedBox(
      width: isTablet ? mediaQuery.size.width * 0.6 : mediaQuery.size.width * 1,
      height: isTablet ? 250 : (mediaQuery.size.height - paddingTop) * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.red,
              width: isTablet
                  ? mediaQuery.size.width * 0.6
                  : mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Front IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Icon(Icons.card_giftcard),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              width: isTablet
                  ? mediaQuery.size.width * 0.6
                  : mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Back IC"),
                  Expanded(
                    child: SizedBox(
                      // width: size.width * 1,
                      child: Center(
                        child: Icon(Icons.card_giftcard),
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

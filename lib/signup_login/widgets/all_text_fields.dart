import 'package:flutter/material.dart';

import '../../responsive_layout_controller.dart';

class AllTextFields extends StatelessWidget {
  const AllTextFields({
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
      height: isTablet
          ? (mediaQuery.size.height - paddingTop) * 0.9
          : (mediaQuery.size.height - paddingTop) * 0.55,
      width: isTablet ? mediaQuery.size.width * 0.4 : null,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: isTablet
                  ? (mediaQuery.size.width - paddingTop) * 0.4
                  : mediaQuery.size.width * 1,
              margin: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 16.0,
                bottom: 8.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Your Position"),
                ),
              ),
            ),
            Container(
              width: isTablet
                  ? (mediaQuery.size.width - paddingTop) * 0.4
                  : mediaQuery.size.width * 1,
              // height: isTablet
              //     ? (mediaQuery.size.height - paddingTop) * 0.2
              //     : (mediaQuery.size.height - paddingTop) * 0.08,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration:
                      const InputDecoration.collapsed(hintText: "Your Name"),
                ),
              ),
            ),
            Container(
              width: isTablet
                  ? (mediaQuery.size.width - paddingTop) * 0.4
                  : mediaQuery.size.width * 1,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration:
                      const InputDecoration.collapsed(hintText: "Your Email"),
                ),
              ),
            ),
            Container(
              width: isTablet
                  ? (mediaQuery.size.width - paddingTop) * 0.4
                  : mediaQuery.size.width * 1,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  decoration: const InputDecoration.collapsed(
                      hintText: "Your Password"),
                ),
              ),
            ),
            Container(
              width: isTablet
                  ? (mediaQuery.size.width - paddingTop) * 0.4
                  : mediaQuery.size.width * 1,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.red,
              ),
              child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Your Address",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

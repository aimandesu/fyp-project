import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.size.width * 1,
      height: (mediaQuery.size.height - paddingTop) * 0.1,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          TextButton(
            onPressed: null,
            child: Text("Login Instead"),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
    required this.showSignUp,
    required this.negateShowSignUp,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;
  final bool showSignUp;
  final VoidCallback negateShowSignUp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQuery.size.width * 1,
      height: (mediaQuery.size.height - paddingTop) * 0.1,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              bottom: 1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: TextButton(
              onPressed: negateShowSignUp,
              child: Text(
                "Login Instead",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

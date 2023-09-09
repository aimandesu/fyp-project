import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  const Bubble({required this.message, required this.isUser, super.key});

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: message.length > 48 ? size.width * 0.7 : null,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Text(
                message,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

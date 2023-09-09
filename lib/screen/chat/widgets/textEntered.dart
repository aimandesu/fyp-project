import 'package:flutter/material.dart';

import '../../../constant.dart';

class TextEntered extends StatelessWidget {
  const TextEntered({required this.chatText, super.key});

  final TextEditingController chatText;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryContainer;
    double circular = 25;

    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      decoration: decorationDefined(color, circular),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 45,
          maxHeight: 100.0,
        ),
        child: TextField(
          decoration: const InputDecoration.collapsed(hintText: 'Message'),
          controller: chatText,
          maxLines: null,
        ),
      ),
    );
  }
}

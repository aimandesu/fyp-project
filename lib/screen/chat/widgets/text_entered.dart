import 'package:flutter/material.dart';

import '../../../constant.dart';

class TextEntered extends StatelessWidget {
  const TextEntered({required this.chatText, super.key});

  final TextEditingController chatText;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryContainer;
    double circular = 25;

    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width * 0.7,
        margin: marginDefined,
        padding: paddingDefined,
        decoration: decorationDefined(color, circular),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 3,
            maxHeight: 100.0,
          ),
          child: TextField(
            decoration: const InputDecoration.collapsed(hintText: 'Mesej'),
            controller: chatText,
            maxLines: null,
          ),
        ),
      ),
    );
  }
}

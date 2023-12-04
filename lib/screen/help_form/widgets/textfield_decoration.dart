import 'package:flutter/material.dart';

class TextFieldDecoration extends StatelessWidget {
  const TextFieldDecoration({
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    super.key,
  });

  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        enableInteractiveSelection: false,
        controller: textEditingController,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
        ),
      ),
    );
  }
}

BoxDecoration inputDecorationDefined(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      width: 1,
      color: Theme.of(context).colorScheme.primary,
    ),
  );
}

import 'package:flutter/material.dart';

import '../../constant.dart';

class LoginSignButton extends StatelessWidget {
  const LoginSignButton({
    required this.changeIsDisplayLogin,
    required this.title,
    required this.option,
    required this.reversedOption,
    required this.loginOrSign,
    super.key,
  });

  final VoidCallback changeIsDisplayLogin;
  final String title;
  final String option;
  final String reversedOption;
  final VoidCallback loginOrSign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          padding: paddingDefined,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: TextButton(
            onPressed: loginOrSign,
            child: Text(option, style: const TextStyle(color: Colors.white)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            TextButton(
              onPressed: changeIsDisplayLogin,
              child: Text(reversedOption),
            ),
          ],
        )
      ],
    );
  }
}

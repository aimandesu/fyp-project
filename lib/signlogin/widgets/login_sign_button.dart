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
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * 0.6,
          margin: marginDefined,
          padding: paddingDefined,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.purple,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            color: Colors.deepPurple,
          ),
          child: TextButton(
            onPressed: loginOrSign,
            child: Text(
              option,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
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

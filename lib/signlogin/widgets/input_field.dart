import 'package:flutter/material.dart';

import '../../constant.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.emailController,
    required this.passwordController,
    // required this.usernameController,
    super.key,
  });

  final TextEditingController emailController;
  // final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool passwordVisibility = true;

  void changePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // InputSetup(
        //   textFormField: TextFormField(
        //     controller: widget.usernameController,
        //     decoration: const InputDecoration.collapsed(
        //       hintStyle: TextStyle(),
        //       hintText: "Username",
        //     ),
        //   ),
        // ),
        InputSetup(
          textFormField: TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration.collapsed(
              hintStyle: TextStyle(),
              hintText: "Email",
            ),
          ),
        ),
        passwordInput(),
      ],
    );
  }

  Container passwordInput() {
    return Container(
      margin: marginDefined,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.purple,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.passwordController,
              decoration: const InputDecoration.collapsed(
                hintStyle: TextStyle(),
                hintText: "Password",
              ),
              obscureText: passwordVisibility,
            ),
          ),
          IconButton(
            onPressed: () => changePasswordVisibility(),
            icon: passwordVisibility
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
          ),
        ],
      ),
    );
  }
}

class InputSetup extends StatelessWidget {
  const InputSetup({required this.textFormField, super.key});
  final TextFormField textFormField;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.purple,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: textFormField,
    );
  }
}

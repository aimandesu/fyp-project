import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

import 'package:fyp_project/services/auth_service.dart';
import 'package:fyp_project/signlogin/widgets/input_field.dart';
import 'package:lottie/lottie.dart';

import 'widgets/login_sign_button.dart';

class SignLogin extends StatefulWidget {
  const SignLogin({super.key});

  @override
  State<SignLogin> createState() => _SignLoginState();
}

class _SignLoginState extends State<SignLogin> {
  bool isDisplayLogin = true;
  bool passwordVisibility = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeIsDisplayLogin() {
    setState(() {
      isDisplayLogin = !isDisplayLogin;
    });
  }

  void loginUser() {
    AuthService().signInWithEmail(
      emailController.text,
      passwordController.text,
    );
  }

  void signUser() {
    AuthService().signUpEmail(
      emailController.text,
      passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height * 1,
            width: size.width * 1,
            child: ResponsiveLayoutController(
              mobile: Column(
                children: [
                  topTitle(size, size.height * 0.35), //0.4
                  buildEmailPassword(size, size.height * 0.3),
                  buildLoginSign(size, size.height * 0.2),
                  buildIconButton(),
                ],
              ),
              tablet: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  topTitle(size, size.height * 0.4),
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: buildEmailPassword(size, size.height * 0.5),
                        ),
                        buildLoginSign(size, size.height * 0.3),
                        buildIconButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
      onPressed: () => AuthService().signInWithGoogle(),
      icon: const Icon(Icons.login),
    );
  }

  SizedBox buildLoginSign(Size size, double height) {
    return SizedBox(
      height: height,
      child: isDisplayLogin
          ? LoginSignButton(
              changeIsDisplayLogin: changeIsDisplayLogin,
              title: "Dont't have an account?",
              option: "Login",
              reversedOption: "Sign Up",
              loginOrSign: loginUser,
            )
          : LoginSignButton(
              changeIsDisplayLogin: changeIsDisplayLogin,
              title: "Have an account?",
              option: "Sign Up",
              reversedOption: "Login",
              loginOrSign: signUser,
            ),
    );
  }

  SizedBox buildEmailPassword(Size size, double height) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputField(
            emailController: emailController,
            passwordController: passwordController,
            // usernameController: usernameController,
          ),
        ],
      ),
    );
  }

  SizedBox topTitle(Size size, double height) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              "Natural Hazard ub",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30,
              ),
            ),
          ),
          Flexible(
            child: Lottie.asset(
              "assets/disaster.json",
            ),
          ),
        ],
      ),
    );
  }
}

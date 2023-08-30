import 'package:flutter/material.dart';

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

  // final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeIsDisplayLogin() {
    setState(() {
      isDisplayLogin = !isDisplayLogin;
    });
  }

  void loginUser() {}

  void signUser() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              topTitle(mediaQuery, paddingTop),
              SizedBox(
                height: mediaQuery.size.height * 0.3,
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
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.3,
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
              ),
              IconButton(
                onPressed: () => AuthService().signInWithGoogle(),

                //here buat signUserInfo funtion gak supposedly
                icon: const Icon(Icons.add_circle_outline_sharp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox topTitle(MediaQueryData mediaQuery, double paddingTop) {
    return SizedBox(
      height: (mediaQuery.size.height - paddingTop) * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Center(
            child: Text(
              "Natural Hazard Hub",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            child: Lottie.asset("assets/disaster.json"),
          ),
        ],
      ),
    );
  }
}

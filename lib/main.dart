import 'package:flutter/material.dart';
import 'package:fyp_project/signup_login/signup_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding/onboarding.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(
    MyApp(
      onboardingComplete: onboardingComplete,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboardingComplete});

  final bool onboardingComplete;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
        ),
      ),
      home: onboardingComplete
          ? const SignupLogin()
          : const Onboarding(), //pass firebase testing stuff inside the signuplogin
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp_project/dbHelper/mongoDB.dart';
import 'package:fyp_project/home/home.dart';
import 'package:fyp_project/main_layout_controller.dart';
import 'package:fyp_project/signup_login/signup_login.dart';
import 'package:fyp_project/user_group/user_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding/onboarding.dart';
import 'profile/profile.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoDB.connect();
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
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(51, 66, 200, 1), //controls appbar
          onPrimary: Colors
              .white, //why is this text color in appbar? Color.fromRGBO(0, 98, 200, 1)
          secondary: Color.fromARGB(255, 190, 36, 87),
          onSecondary: Colors.orange,
          error: Colors.red,
          onError: Colors.green,
          background: Colors.yellow,
          onBackground: Colors.teal,
          surface: Color.fromRGBO(51, 66, 200, 1), //controls appbar
          onSurface: Colors.white, //controls appbar
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: onboardingComplete
          ? const MainLayoutController() //default: SignUpLogin(), pass firebase testing stuff inside the signuplogin
          : const MainLayoutController(), //Onboarding(),
      routes: {
        Profile.routeName: (context) => const Profile(),
      },
    );
  }
}

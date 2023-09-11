import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/onboarding/onboarding.dart';
import 'package:fyp_project/providers/chat_provider.dart';

import 'package:fyp_project/screen/help_form/widgets/camera/picture_display.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/pdf/pdf_upload.dart';
import 'package:fyp_project/main_layout_controller.dart';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:fyp_project/providers/profile_provider.dart';
import 'package:fyp_project/screen/verification/verification.dart';
import 'package:fyp_project/signlogin/signlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'screen/chat/chat.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  final switchTheme = prefs.getBool('switchTheme') ?? false;

  runApp(
    MyApp(
      onboardingComplete: onboardingComplete,
      switchTheme: switchTheme,
      // prefs: prefs,
    ),
  );
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
   MyApp({
    required this.onboardingComplete,
    required this.switchTheme,
    // required this.prefs,
    super.key,
  });

  final bool onboardingComplete;
   bool switchTheme;
  // final SharedPreferences prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  void toggleTheme() async {

    setState(() {
      widget.switchTheme =  !widget.switchTheme;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("switchTheme", widget.switchTheme);
    // print("here");
    // print(prefs.getBool("switchTheme"));
    // setState(() {
    // themeDefault = prefs.getBool("switchTheme");

    // });
  }

  // Future<void> triggerSharedPreference() async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // bool currentTheme = prefs.getBool('switchTheme') ?? false;
  //   // themeDefault = currentTheme;
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //still dont understand how this works?
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          brightness: widget.switchTheme? Brightness.dark : Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: widget.onboardingComplete
            ? StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return  MainLayoutController(themeDefault: widget.switchTheme, toggleTheme: toggleTheme,); //pass toggle here, switch dark mode and vice versa
                  } else {
                    return const SignLogin();
                  }
                }) //default: SignUpLogin(), pass firebase testing stuff inside the signuplogin
            : const Onboarding(),
        //Onboarding(),
        routes: {
          PictureUpload.routeName: (context) => const PictureUpload(),
          PDFUpload.routeName: (context) => const PDFUpload(),
          PictureDisplay.routeName: (context) => const PictureDisplay(),
          Chat.routeName: (context) => const Chat(),
          Verification.routeName: (context) => const Verification(),
        },
      ),
    );
  }
}

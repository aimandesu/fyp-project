import 'package:flutter/material.dart';

import 'package:fyp_project/screen/help_form/widgets/camera/picture_display.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/pdf/pdf_upload.dart';
import 'package:fyp_project/main_layout_controller.dart';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:fyp_project/providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
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
          PictureUpload.routeName: (context) => const PictureUpload(),
          PDFUpload.routeName: (context) => const PDFUpload(),
          PictureDisplay.routeName: (context) => const PictureDisplay(),
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_project/admin/admin.dart';
import 'package:fyp_project/onboarding/onboarding.dart';
import 'package:fyp_project/providers/chat_provider.dart';
import 'package:fyp_project/providers/support_result_provider.dart';
import 'package:fyp_project/screen/help_centre/help_centre.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_display.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_upload.dart';
import 'package:fyp_project/screen/help_form/widgets/pdf/pdf_upload.dart';
import 'package:fyp_project/main_layout_controller.dart';
import 'package:fyp_project/providers/maps_provider.dart';
import 'package:fyp_project/providers/profile_provider.dart';
import 'package:fyp_project/screen/news/widgets/news_content.dart';
import 'package:fyp_project/screen/report_incident/report_incident.dart';
import 'package:fyp_project/screen/support_result/dart/support_result.dart';
import 'package:fyp_project/screen/support_result/dart/widgets/result.dart';
import 'package:fyp_project/screen/verification/verification.dart';
import 'package:fyp_project/services/fcm_service.dart';
import 'package:fyp_project/signlogin/signlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'screen/chat/chat.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

//use ctrl alt l for reformat - just save
//use alt enter to wrap widget - ctrl with dot

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //initialise messaging
  FcmService().setupInteractedMessage();
  //check if fcm is still valid, if not update
  //do above function here
  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  final switchTheme = prefs.getBool('switchTheme') ?? false;

  runApp(
    MyApp(
      onboardingComplete: onboardingComplete,
      switchTheme: switchTheme,
    ),
  );
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({
    required this.onboardingComplete,
    required this.switchTheme,
    super.key,
  });

  final bool onboardingComplete;
  bool switchTheme;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleTheme() async {
    setState(() {
      widget.switchTheme = !widget.switchTheme;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("switchTheme", widget.switchTheme);
  }

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
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SupportResultProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          brightness: widget.switchTheme ? Brightness.dark : Brightness.light,
          colorSchemeSeed: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: kIsWeb
            ? Admin(
                themeDefault: widget.switchTheme,
                toggleTheme: toggleTheme,
              )
            : widget.onboardingComplete
                ? StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MainLayoutController(
                          themeDefault: widget.switchTheme,
                          toggleTheme: toggleTheme,
                        );
                      } else {
                        return const SignLogin();
                      }
                    })
                : const Onboarding(),
        routes: {
          PictureUpload.routeName: (context) => const PictureUpload(),
          PDFUpload.routeName: (context) => const PDFUpload(),
          PictureDisplay.routeName: (context) => const PictureDisplay(),
          Chat.routeName: (context) => const Chat(),
          Verification.routeName: (context) => const Verification(),
          SupportResult.routeName: (context) => const SupportResult(),
          Result.routeName: (context) => const Result(),
          HelpCentre.routeName: (context) => const HelpCentre(),
          ReportIncidence.routeName: (context) => const ReportIncidence(),
          NewsContent.routeName: (context) => const NewsContent(),
        },
      ),
    );
  }
}

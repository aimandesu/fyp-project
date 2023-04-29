import 'package:flutter/material.dart';
import 'package:fyp_project/responsive_layout_controller.dart';

import 'widgets/all_text_fields.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/ic_image.dart';

class SignupLogin extends StatelessWidget {
  const SignupLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ResponsiveLayoutController(
          mobile: Column(
            children: [
              ICimage(mediaQuery: mediaQuery, paddingTop: paddingTop),
              AllTextFields(mediaQuery: mediaQuery, paddingTop: paddingTop),
              BottomBar(mediaQuery: mediaQuery, paddingTop: paddingTop),
            ],
          ),
          tablet: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ICimage(mediaQuery: mediaQuery, paddingTop: paddingTop),
                  AllTextFields(mediaQuery: mediaQuery, paddingTop: paddingTop),
                ],
              ),
              BottomBar(mediaQuery: mediaQuery, paddingTop: paddingTop),
            ],
          ),
        ),
      ),
    );
  }
}

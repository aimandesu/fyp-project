import 'package:flutter/material.dart';
import 'package:fyp_project/signup_login/signup_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageviewController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageviewController,
          onPageChanged: (index) {
            setState(
              () => isLastPage = index == 2,
            );
          },
          children: [
            Container(
              color: Colors.red,
              child: const Center(
                child: Text("page 1"),
              ),
            ),
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text("page 2"),
              ),
            ),
            Container(
              color: Colors.pink,
              child: const Center(
                child: Text("page 3"),
              ),
            )
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('onboardingComplete', true);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupLogin()));
              },
              child: const Text("Get Started"),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => pageviewController.jumpToPage(2),
                    child: const Text("SKIP"),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageviewController,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black,
                        activeDotColor: Colors.yellow,
                      ),
                      onDotClicked: (index) => pageviewController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => pageviewController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text("NEXT"),
                  ),
                ],
              ),
            ),
    );
  }
}

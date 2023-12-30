import 'package:flutter/material.dart';
import 'package:fyp_project/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../signlogin/signlogin.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageViewController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  void saveOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          "Natural Disaster",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageViewController,
          onPageChanged: (index) {
            setState(
              () => isLastPage = index == 2,
            );
          },
          children: const [
            OnboardingPage(
              lottieDir: 'assets/map.json',
              text: "Location Disaster Alert",
            ),
            OnboardingPage(
              lottieDir: 'assets/help.json',
              text: "Support Cause",
            ),
            OnboardingPage(
              lottieDir: 'assets/disaster.json',
              text: "Together help",
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Center(
                child: TextButton(
                    onPressed: () {
                      saveOnboardingComplete();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignLogin();
                      }));
                    },
                    child: const Text("Get Started")),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => pageViewController.jumpToPage(2),
                    child: const Text("SKIP"),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: pageViewController,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black,
                          activeDotColor:
                              Theme.of(context).colorScheme.primary),
                      onDotClicked: (index) => pageViewController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => pageViewController.nextPage(
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

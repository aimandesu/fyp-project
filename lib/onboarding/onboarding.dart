import 'package:flutter/material.dart';
import 'package:fyp_project/onboarding/onboarding_page.dart';
import 'package:fyp_project/screen/verification/verification.dart';
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

  void saveOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onboardingComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        // backgroundColor: Colors.white,
        title: const Text(
          "Natural Disaster",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageviewController,
          onPageChanged: (index) {
            setState(
              () => isLastPage = index == 2,
            );
          },
          children: const [
            OnboardingPage(
              lottieDir: 'assets/map.json',
              text: "Disaster Place Donation",
            ),
            OnboardingPage(
              lottieDir: 'assets/help.json',
              text: "Support Cause",
            ),
            OnboardingPage(
              lottieDir: 'assets/disaster.json',
              text: "Together help",
            ),
            // Container(
            //   color: Colors.red,
            //   child: const Center(
            //     child: Text("page 1"),
            //   ),
            // ),
            // Container(
            //   color: Colors.blue,
            //   child: const Center(
            //     child: Text("page 2"),
            //   ),
            // ),
            // Container(
            //   color: Colors.pink,
            //   child: const Center(
            //     child: Text("page 3"),
            //   ),
            // )
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () {
                saveOnboardingComplete();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Verification();
                }));
              },
              child: const Row(children: [
                Spacer(),
                Text("Get Started"),
              ]),
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
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black,
                          activeDotColor:
                              Theme.of(context).colorScheme.primary),
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

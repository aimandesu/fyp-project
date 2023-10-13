import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.lottieDir,
    required this.text,
  });

  final String lottieDir;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Lottie.asset(lottieDir)),
        Text(text),
        const SizedBox(height: 10,)
      ],
    );
  }
}

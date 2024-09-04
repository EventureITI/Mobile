import 'package:eventure/screens/onboarding_screens/onboarding_screen_1.dart';
import 'package:eventure/screens/onboarding_screens/onboarding_screen_2.dart';
import 'package:eventure/screens/onboarding_screens/onboarding_screen_3.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          OnboardingScreen1(pageController: _pageController),
          OnboardingScreen2(pageController: _pageController),
          OnboardingScreen3(pageController: _pageController),
        ],
      ),
    );
  }
}

import 'package:eventure/contactUs.dart';
import 'package:eventure/onboardingScreen1.dart';
import 'package:eventure/onboardingScreen2.dart';
import 'package:eventure/onboardingScreen3.dart';
import 'package:flutter/material.dart';

class OnboardingPageView extends StatelessWidget {
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
          ContactUsScreen(),
        ],
      ),
    );
  }
}

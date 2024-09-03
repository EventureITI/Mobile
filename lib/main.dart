import 'package:eventure/screens/home_screen.dart';
import 'package:eventure/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),

        theme: ThemeData.dark(),

        // home: ContactUsScreen(),
        // home: OnboardingPageView(),
        // home: PaymentSuccessScreen(),
        // home: FailScreen(),
        // home: GetTicketScreen(),
        home: LoginScreen());
  }
}

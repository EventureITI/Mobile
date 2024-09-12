import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/firebase_options.dart';
import 'package:eventure/screens/home_screens/home_screen.dart';
import 'package:eventure/screens/no_internet_screen.dart';
import 'package:eventure/screens/onboarding_screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // print('API Key: ${dotenv.env["AND_API_KEY"]}');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  Stripe.publishableKey = dotenv.env['STRIPE_PK']!;
  // print(DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: chuckCoated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking
          return MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator())));
        } else if (snapshot.hasData && snapshot.data == true) {
          // If connected, show the HomeScreen
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Eventure',
            theme: ThemeData.dark(),
            home: HomeScreen(),
          );
        } else {
          // If not connected, show NoInternetScreen
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Eventure',
            theme: ThemeData.dark(),
            home: NoInternetScreen(),
          );
        }
      },
    );
  }
}

Future<bool> chuckCoated() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

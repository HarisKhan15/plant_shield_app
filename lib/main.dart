// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_shield_app/api/firebase_api.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/features/login/login_page.dart';
import 'package:plant_shield_app/features/signup/signup-page.dart';
import 'package:plant_shield_app/features/splash/splash-page.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(MaterialApp(
      title: "Plant Shield",
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/welcome': (context) => WelcomeScreen(
              username: '',
            ),
        '/home': (context) => HomeScreen(),
      }));
}

class UrlConfig {
  static const String baseUrl = "http://10.0.2.2:5000";
  static const String baseUrlNgrok = "http://192.168.0.104:5000";
  static const String prodUrl = "http://4.240.96.138:8080";

  static Uri buildUri(String path) {
    return Uri.parse("$prodUrl/$path");
  }
}

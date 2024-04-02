// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/features/login/login_page.dart';
import 'package:plant_shield_app/features/signup/signup-page.dart';
import 'package:plant_shield_app/features/splash/splash-page.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';

void main() {
  runApp(MaterialApp(
      title: "Plant Sheild",
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/otp': (context) => OtpScreen(),
        '/welcome': (context) => WelcomeScreen(
              username: '',
            ),
        '/home': (context) => HomeScreen(),
      }));
}

class UrlConfig {
  static const String baseUrl = "http://10.0.2.2:5000";
  static const String baseUrlNgrok =
      "https://c661-111-88-196-14.ngrok-free.app";

  static Uri buildUri(String path) {
    return Uri.parse("$baseUrlNgrok/$path");
  }
}

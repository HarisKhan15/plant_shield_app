// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/features/login/login-page.dart';
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
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
      }));
}

class UrlConfig {
static const String baseUrl = "http://192.168.1.103:8080/";


  static Uri buildUri(String path) {
    return Uri.parse("$baseUrl/$path");
  }
}
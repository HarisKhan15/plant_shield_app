// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/features/signin/signin-page.dart';
import 'package:plant_shield_app/features/signup/signup-page.dart';
import 'package:plant_shield_app/features/splash/splash-page.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Plant Sheild",
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/signin': (context) => SigninScreen(),
        '/signup': (context) => SignupScreen(),
        '/otp': (context) => OtpScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomeScreen(),
      }));
}

// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/login/login-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Stack(children: [
          //logo
          Positioned(
              child: Image.asset(
                'assets/splashlogo.png',
                height: MediaQuery.of(context).size.height * 0.45,
              ),
              top: MediaQuery.of(context).size.height * 0.45,
              left: 0,
              right: 0),
          //leaf
          Positioned(
              child: Image.asset(
                'assets/leaf.png',
                height: MediaQuery.of(context).size.height * 0.86,
              ),
              top: 0,
              right: -10,
              left: 0),
        ]),
      ),
    ));
  }
}

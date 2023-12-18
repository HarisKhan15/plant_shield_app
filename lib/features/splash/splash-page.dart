// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/signin/signin-page.dart';

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
          MaterialPageRoute(builder: (context) => SigninScreen()),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Center(
          child: Stack(
            children: [
 //logo             
            Positioned(
            child: Image.asset('assets/splashlogo.png',height: 350,
              ),
              bottom: 90, 
              left: 10
            ),
 //leaf           
            Positioned(
              child: Image.asset('assets/leaf.png',height: 790,
              ),
              left: 17, 
             
            ),
            ]
          ),
      ),
      )
    );
  }
}
// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences loginUser;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () async {
        loginUser = await SharedPreferences.getInstance();
        newuser = (loginUser.getBool('login') ?? true);
        if (newuser == false) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Stack(children: [
          //leaf
          Positioned(
            child: Image.asset('assets/leaf1.png'),
            right: -410,
            bottom: 98,
          ),

          //logo
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/finallogo.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                SizedBox(height: 15),
                Text(
                  'PLANT SHIELD',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 24 : 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C7031),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Plant Disease Detection and Prediction',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 10,
                    color: Color(0xFF4C7031),
                  ),
                ),
              ],
            ),
            top: MediaQuery.of(context).size.height * 0.58,
            left: 0,
            right: 0,
          ),
        ]),
      ),
    ));
  }
}

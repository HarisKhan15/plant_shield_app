// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserPlantLoader extends StatefulWidget {
  const UserPlantLoader({Key? key});

  @override
  State<UserPlantLoader> createState() => _UserPlantLoaderState();
}

class _UserPlantLoaderState extends State<UserPlantLoader> {
  String _displayText = 'Identifying your plant..';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _displayText = 'Detecting your plant..';
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _displayText = 'Analysis successful!';
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.network(
                    'https://lottie.host/fe8da8b0-4672-477e-a873-ce11fdf87cd5/h9rU4CzL15.json',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _displayText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }
}

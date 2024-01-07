// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 50.0, // Set the width of the loader circle
            height: 50.0, // Set the height of the loader circle
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF58964D)),
              strokeWidth: 4.0,
            ),
          ),
        );
      },
    );
  }
}

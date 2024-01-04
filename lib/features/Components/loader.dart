// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
           backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF58964D)),
            ),
          ),
        );
      },
    );
  }
}

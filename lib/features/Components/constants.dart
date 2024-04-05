// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Constants {
  //Primary color
  static var primaryColor = const Color(0xFF449636);
  static var blackColor = Colors.black54;

  //Onboarding texts
  static var titleOne = "Learn more about plants";
  static var descriptionOne =
      "Read how to care for plants in our rich plants guide.";
  static var titleTwo = "Find a plant lover friend";
  static var descriptionTwo =
      "Are you a plant lover? Connect with other plant lovers.";
  static var titleThree = "Plant a tree, green the Earth";
  static var descriptionThree =
      "Find almost all types of plants that you like here.";
}
//text feild styling
InputDecoration constantInputDecoration({
  required String hintText,
  String? suffixImagePath,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    fillColor: Colors.grey.shade100,
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    suffixIcon: suffixImagePath != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(suffixImagePath),
            ),
          )
        : null,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2.0,
      ),
    ),
  );
}

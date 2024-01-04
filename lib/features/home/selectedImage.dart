import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';

class SelectedImageScreen extends StatelessWidget {
  final File imageFile;

  const SelectedImageScreen({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Image'),
        backgroundColor: Constants.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(imageFile),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Constants.primaryColor,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //   ),
            //   child: Text('Add to My Plants'),
            // ),
          ],
        ),
      ),
    );
  }
}

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
          ],
        ),
      ),
    );
  }
}

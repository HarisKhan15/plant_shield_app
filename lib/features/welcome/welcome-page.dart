// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_shield_app/models/profile.dart';
import 'dart:io';
import 'dart:convert';
import 'package:plant_shield_app/services/profile-service.dart';

class WelcomeScreen extends StatefulWidget {
  final String username;

  const WelcomeScreen({super.key, required this.username});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final ProfileService profileService = ProfileService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? imageFile;

  Future<void> _Next() async {
    if (_formKey.currentState!.validate()) {
      try {
        Profile profile = _constructRegistrationObject();
        var response = await profileService.createProfile(imageFile, profile);
        if (response != null && response.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          Map<String, dynamic> errorJson = jsonDecode(response!.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorJson['error']),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error. Please try again.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Profile _constructRegistrationObject() {
    return Profile(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: widget.username);
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
      imageFile = File(pickedFile.path);
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: Stack(children: [
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2,
                          right: 10,
                          left: 10),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            //welcome
                            Text(
                              'Welcome!',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF236419),
                              ),
                            ),

                            SizedBox(height: 40.0),
//profile
                            GestureDetector(
                              onTap: _getImageFromGallery,
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: imageFile != null
                                    ? FileImage(imageFile!)
                                        as ImageProvider<Object>?
                                    : AssetImage('assets/profile.png'),
                              ),
                            ),
                            SizedBox(height: 5),
//divider
                            Container(
                              width: 324,
                              child: Divider(
                                  color: Color(0xFF449636),
                                  thickness: 2.03,
                                  height: 80),
                            ),

                            SizedBox(height: 10),
                            //fullname
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset('assets/user.png'),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            //fullname
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'last Name',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset('assets/user.png'),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 255,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF449636),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: _Next,
                                    icon: Text(
                                      'Next',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]))))
            ])));
  }
}

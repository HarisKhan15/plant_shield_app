// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home_page.dart';

class WelcomeScreen extends StatefulWidget {
  final String username;
  
  const WelcomeScreen({super.key, required this.username});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _FullnameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _Next() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
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
                            CircleAvatar(
                              radius: 55.0,
                              backgroundImage: AssetImage('assets/profile.png'),
                            ),

                            SizedBox(height: 20.0),
//divider
                            Container(
                              width: 324,
                              child: Divider(
                                  color: Color(0xFF449636),
                                  thickness: 2.03,
                                  height: 80),
                            ),

                            SizedBox(height: 20.0),
                            //fullname
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _FullnameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Fullname';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'FullName',
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

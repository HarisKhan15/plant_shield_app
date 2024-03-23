// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/forgetPassword/changePassword_page.dart';
import 'package:plant_shield_app/features/forgetPassword/codeScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _validateEmail() async {
    if (_emailController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CodeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
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
              //logo
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - 150,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo2.png',
                    height: 300,
                  ),
                ),
              ),
              SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.38,
                          right: 10,
                          left: 10),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
//message                             
                              child: Text(
                                "Please enter your email,you will receive a code to reset your password via email.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ),
                            SizedBox(height: 45),
//Email                           
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is empty';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                      .hasMatch(value)) {
                                    if (value.isNotEmpty) {
                                      return 'Enter a valid email';
                                    } else {
                                      return null; // Return null if email is empty and no validation yet
                                    }
                                  }
                                  return null;
                                },
                                decoration: constantInputDecoration(
                                  hintText: 'Email',
                                  suffixImagePath: 'assets/mail.png'),
                              ),
                            ),
                            SizedBox(height: 40),
//button                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 255,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: _validateEmail,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color(0xFF449636)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                    ),
                                    child: Text(
                                      'Send code',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ])))),
            ])));
  }
}

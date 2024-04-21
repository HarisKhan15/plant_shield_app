// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/changepassword/change-password-page.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _validateUsername() async {
    if (_usernameController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChangePasswordScreen(fromSettings: false,)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your username.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
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
                      left: 10,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Padding(
                                  padding: EdgeInsets.only(
                                    right: 12,
                                    left: 12,
                                  ),
                                  child: Text(
                            "Please enter the username associated with your account to proceed with changing your password.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          )),
                          SizedBox(height: 45),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              controller: _usernameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username is empty';
                                }

                                return null;
                              },
                              decoration: constantInputDecoration(
                                hintText: 'Username',
                                suffixImagePath: 'assets/user.png',
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 255,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: _validateUsername,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF449636)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    'Next',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

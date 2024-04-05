// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/forgetPassword/changePassword_page.dart';
import 'package:plant_shield_app/features/login/login_page.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  List<TextEditingController> _CodeControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _CodeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isCodeEntered() {
    List<String> otpValues =
        List.generate(6, (index) => _CodeControllers[index].text);
    return !otpValues.contains('');
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code will be resent to your email.'),
      ),
    );
    // implement the logic to resend the code to the email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
// Logo
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
                top: MediaQuery.of(context).size.height * 0.4,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
// Message
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Please enter the verification code sent to your email ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: "abc.123@gmail.com",
                            style: TextStyle(
                                color: Constants.primaryColor, fontSize: 13),
                          ),
                          TextSpan(
                            text: " to reset your password.",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        width: 38,
                        height: 45,
                        child: TextField(
                          controller: _CodeControllers[index],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            counterText: '',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
// Verify Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 255,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (_isCodeEntered()) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please enter the complete verification code.'),
                                ),
                              );
                            }
                          },
                          icon: Text(
                            'verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

// Didn’t receive any code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn’t receive any code?',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xfff4c505b),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _resendCode();
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

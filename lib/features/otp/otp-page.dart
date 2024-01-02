// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isOtpEntered() {
    List<String> otpValues =
        List.generate(6, (index) => _otpControllers[index].text);
    return !otpValues.contains('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo
          Positioned(
            left: 43,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo.png',
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
                                "Please enter the 6-digit code sent to your email ",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          TextSpan(
                            text: "abc.123@gmail.com",
                            style: TextStyle(
                                color: Color(0xFF58964D), fontSize: 13),
                          ),
                          TextSpan(
                            text: " for verification.",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      6,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        width: 38,
                        height: 45,
                        child: TextField(
                          controller: _otpControllers[index],
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            counterText: '',
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
                          color: Color(0xFF449636),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (_isOtpEntered()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(username: '',)),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Please enter the complete OTP.'),
                                ),
                              );
                            }
                          },
                          icon: Text(
                            'Verify',
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
                        onPressed: () {},
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF58964D),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';
import 'package:plant_shield_app/models/user-registration.dart';
import 'package:plant_shield_app/models/verify-otp.dart';
import 'package:plant_shield_app/services/otp-service.dart';
import 'package:plant_shield_app/services/user-service.dart';

class OtpScreen extends StatefulWidget {
  final UserRegistration userRegistration;
  const OtpScreen({Key? key, required this.userRegistration}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  final UserService _userService = UserService();
  final OTPService _otpService = OTPService();
  UserRegistration? userRegistration;

  @override
  void initState() {
    super.initState();
    userRegistration = widget.userRegistration;
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> verifyOtpAndSignIn() async {
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);
      VerifyOTP verifyOTP = _constructVerifyOTPObject();
      response = await _otpService.otpVerification(verifyOTP);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (response != null && response.statusCode == 200) {
      registerUser();
    } else {
      Navigator.of(context).pop();
      Map<String, dynamic> errorJson = jsonDecode(response!.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorJson['error']),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      dispose();
    }
  }

  Future<void> registerUser() async {
    Response? response;
    try {
      response = await _userService.registerUser(userRegistration!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
    if (response != null && response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WelcomeScreen(username: userRegistration!.username)),
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
  }

  VerifyOTP _constructVerifyOTPObject() {
    List<String> otpValues =
        _otpControllers.map((controller) => controller.text).toList();
    int otp = int.parse(otpValues.join(''));
    return VerifyOTP(otp: otp, email: userRegistration!.email);
  }

  bool _isOtpEntered() {
    List<String> otpValues =
        List.generate(6, (index) => _otpControllers[index].text);
    return !otpValues.contains('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 4,
        backgroundColor: Colors.transparent,
        // expandedHeight: size.height * 0.07,
        // pinned: true,
        // backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
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
              Container(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                            TextSpan(
                              text: userRegistration!.email,
                              style: TextStyle(
                                  color: Constants.primaryColor, fontSize: 13),
                            ),
                            TextSpan(
                              text: " for verification.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
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
                            color: Constants.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              if (_isOtpEntered()) {
                                verifyOtpAndSignIn();
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
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

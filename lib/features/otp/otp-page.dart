// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/changepassword/change-password-page.dart';
import 'package:plant_shield_app/features/welcome/welcome-page.dart';
import 'package:plant_shield_app/models/user-registration.dart';
import 'package:plant_shield_app/models/verify-otp.dart';
import 'package:plant_shield_app/services/otp-service.dart';
import 'package:plant_shield_app/services/user-service.dart';

class OtpScreen extends StatefulWidget {
  final UserRegistration userRegistration;
  final String pageType;
  const OtpScreen(
      {Key? key, required this.userRegistration, required this.pageType})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  final UserService _userService = UserService();
  final OTPService _otpService = OTPService();
  UserRegistration? userRegistration;
  String? pageType;

  late Timer _timer;
  int _start = 60;
  bool _timerExpired = false;
  @override
  void initState() {
    super.initState();
    userRegistration = widget.userRegistration;
    pageType = widget.pageType;
    startTimer();
  }

  Future<void> verifyOtp() async {
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
      if (pageType == Constants.SIGN_UP) {
        registerUser();
      } else if (pageType == Constants.FORGET_PASSWORD) {
        forgetPassword();
      }
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
      clearOtp();
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

  void forgetPassword() {
    Navigator.of(context).pop();
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(
                    fromSettings:false,
                    username: userRegistration!.username,
                  )),
        );
  }

  Future<void> _resendOtp() async {
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);
      response = await _otpService.generateOTP(userRegistration!.email);
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
      setState(() {
        _timerExpired = false;
        _start = 60;
        startTimer();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("OTP Send successfully"),
          duration: Duration(seconds: 2),
          backgroundColor: Constants.primaryColor,
        ),
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

  void clearOtp() {
    setState(() {
      _otpControllers = List.generate(6, (index) => TextEditingController());
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _timerExpired = true; // Set timerExpired flag to true
            _otpControllers.forEach((controller) {
              controller.clear(); // Clear OTP fields
            });
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
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
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo2.png',
                    height: 400,
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
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            TextSpan(
                              text: userRegistration!.email,
                              style: TextStyle(
                                  color: Constants.primaryColor, fontSize: 16),
                            ),
                            TextSpan(
                              text: " for verification.",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          width: 42,
                          height: 50,
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
                            enabled:
                                !_timerExpired, // Disable text editing if timer is expired
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //OTP Verification timer
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _start > 0 ? '$_start ' : '',
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: _start > 0
                                  ? 'seconds remaining to enter OTP'
                                  : 'Time expired. Click on Resend',
                              style: TextStyle(
                                color: _start > 0 ? Colors.black : Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 80),

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
                                verifyOtp();
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

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _start > 0 ? '  Didn’t receive any code?' : '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xfff4c505b),
                          ),
                        ),
                        TextButton(
                          onPressed: _start > 0 ? null : _resendOtp,
                          child: Text(
                            _start > 0 ? 'Resend' : 'Click to Resend',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _start > 0
                                  ? Constants.primaryColor
                                  : Colors.red,
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

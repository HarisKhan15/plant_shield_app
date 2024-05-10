// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/changepassword/change-password-page.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/models/user-registration.dart';
import 'package:plant_shield_app/services/otp-service.dart';
import 'package:plant_shield_app/services/user-service.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  final UserService _userService = UserService();
  final OTPService _otpService = OTPService();

  Future<void> _validateUsername() async {
    if (_usernameController.text.isNotEmpty) {
      Response? response;
      String username = _usernameController.text;
      String? userEmail;
      try {
        LoadingDialog.showLoadingDialog(context);
        userEmail = await checkUsernameExist(username);
        if (userEmail == null) {
          return;
        }
        response = await _otpService.generateOTP(userEmail);
      } catch (e) {
        print("Error: $e");
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
        UserRegistration userRegistration = UserRegistration(userEmail!, username, '');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    userRegistration: userRegistration,
                    pageType: Constants.FORGET_PASSWORD,
                  )),
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
  }

  Future<String?> checkUsernameExist(String username) async {
    Response? isUserExist;
    try {
      isUserExist = await _userService.checkUserByUsername(username);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (isUserExist != null && isUserExist.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(isUserExist.body);
      if (responseBody['exists']) {
        return responseBody['email'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User not exist with provided username!"),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        clearUsername();
      }
    } else {
      Map<String, dynamic> errorJson = jsonDecode(isUserExist!.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorJson['error']),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }

  void clearUsername() {
    setState(() {
      _usernameController = TextEditingController();
    });
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

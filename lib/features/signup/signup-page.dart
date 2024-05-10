// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, implementation_imports

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/otp/otp-page.dart';
import 'package:plant_shield_app/models/user-registration.dart';
import 'package:plant_shield_app/services/otp-service.dart';
import 'package:plant_shield_app/services/user-service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserService _userService = UserService();
  final OTPService _otpService = OTPService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _hasText = false;
  bool _hasConfirmText = false;

  @override
  void initState() {
    super.initState();
  }

  UserRegistration _constructRegistrationObject() {
    return UserRegistration(_emailController.text, _usernameController.text,
        _passwordController.text);
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      Response? response;
      UserRegistration userRegistration = _constructRegistrationObject();
      try {
        LoadingDialog.showLoadingDialog(context);
        bool isUserValidate = await _validateUser(userRegistration);
        if (!isUserValidate) {
          return;
        }
        response = await _otpService.generateOTP(userRegistration.email);
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
                  OtpScreen(userRegistration: userRegistration,
                  pageType: Constants.SIGN_UP,)),
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

  Future<bool> _validateUser(UserRegistration userRegistration) async {
    Response? response;
    try {
      response = await _userService.validateUser(userRegistration);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (response != null && response.statusCode == 200) {
      return true;
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

    return false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 4,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Form(
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
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35,
                      right: 10,
                      left: 10,
                    ),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //email
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
                                      return null; 
                                    }
                                  }
                                  return null;
                                },
                                decoration: constantInputDecoration(
                                  hintText: 'Email',
                                  suffixImagePath:
                                      'assets/mail.png', 
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            //username
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                                decoration: constantInputDecoration(
                                    hintText: 'Username',
                                    suffixImagePath: 'assets/user.png'),
                              ),
                            ),
                            SizedBox(height: 10),
                            // Password
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a Password';
                                  }
                                  return null;
                                },
                                obscureText: _isObscurePassword,
                                onChanged: (value) {
                                  setState(() {
                                    _hasText = value.isNotEmpty;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isObscurePassword =
                                                !_isObscurePassword;
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            _hasText
                                                ? (_isObscurePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility)
                                                : null,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: _hasText
                                            ? SizedBox.shrink()
                                            : Image.asset(
                                                'assets/lock.png',
                                                width: 24,
                                                height: 24,
                                              ),
                                      ),
                                    ],
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Constants.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

// Confirm Password
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    return 'Password does not match';
                                  }
                                  return null;
                                },
                                obscureText: _isObscureConfirmPassword,
                                onChanged: (value) {
                                  setState(() {
                                    _hasConfirmText = value.isNotEmpty;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  fillColor: Colors.grey.shade100,
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isObscureConfirmPassword =
                                                !_isObscureConfirmPassword;
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Icon(
                                            _hasConfirmText
                                                ? (_isObscureConfirmPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility)
                                                : null,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: _hasConfirmText
                                            ? SizedBox.shrink()
                                            : Image.asset(
                                                'assets/lock.png',
                                                width: 24,
                                                height: 24,
                                              ),
                                      ),
                                    ],
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Constants.primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
//sign up button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 255,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: _signUp,
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
                                      'Sign Up',
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
//dividers
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 90,
                                  ),
                                ),
                                Text('or',
                                    style: TextStyle(
                                        color: Color(0xFF58964D),
                                        fontSize: 16)),
                                Container(
                                  width: 150,
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                    height: 90,
                                  ),
                                ),
                              ],
                            ),

//dont have account
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xfff4c505b),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF58964D),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  )
                ]))));
  }
}

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/login/login_page.dart';
import 'package:plant_shield_app/models/update-password.dart';
import 'package:plant_shield_app/services/user-service.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool fromSettings;
  final String username;

  const ChangePasswordScreen(
      {Key? key, required this.fromSettings, required this.username})
      : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isObscureCurrentPassword = true;
  bool _hasText = false;
  bool _hasConfirmText = false;
  bool _hasCurrentPasswordText = false;
  final UserService _userService = UserService();

  void _changePasswordValidation() async {
    if (_formKey.currentState!.validate()) {
      LoadingDialog.showLoadingDialog(context);

      if (widget.fromSettings) {
        bool isCurrentPasswordMatched = await validateCurrentPassword(
            widget.username, _currentPasswordController.text);
        if (!isCurrentPasswordMatched) {
          Navigator.of(context).pop();
          return;
        }
      }

      String password = _passwordController.text;
      if (!isValidPassword(password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid password. Please check the requirements.',
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
        return;
      }

      updatePassword();
    }
  }

  void updatePassword() async {
    Response? response;
    UpdatePassword updatePasswordObj = _constructUpdatePasswordObject();
    try {
      response = await _userService.updatePassword(updatePasswordObj);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password Updated successfully.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
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

  Future<bool> validateCurrentPassword(
      String username, String currentPassword) async {
    Response? response;
    try {
      response =
          await _userService.validateCurrentPassword(username, currentPassword);
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (response == null || response.statusCode != 200) {
      Map<String, dynamic> errorJson = jsonDecode(response!.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorJson['error']),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  UpdatePassword _constructUpdatePasswordObject() {
    return UpdatePassword(widget.username, _passwordController.text);
  }

  bool isValidPassword(String password) {
    if (password.length < 8) {
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }

    return true;
  }

  Widget _currentPasswordField(BuildContext context) {
    if (widget.fromSettings) {
      return TextFormField(
        controller: _currentPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Current Password';
          }
          return null;
        },
        obscureText: _isObscureCurrentPassword,
        onChanged: (value) {
          setState(() {
            _hasCurrentPasswordText = value.isNotEmpty;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          fillColor: Colors.grey.shade100,
          hintText: 'Current Password',
          hintStyle: TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _hasCurrentPasswordText
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscureCurrentPassword =
                              !_isObscureCurrentPassword;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          _isObscureCurrentPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _hasCurrentPasswordText
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
      );
    } else {
      return SizedBox.shrink();
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
                child: Stack(children: [
                  // logo
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
                            top: MediaQuery.of(context).size.height * 0.34,
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
                                    textAlign: TextAlign.justify,
                                    "For better security, your password should be at least 8 characters long and include a combination of letters, numbers, and symbols.",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 45),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: _currentPasswordField(context),
                                ),
                                SizedBox(height: 20),
//new Password
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
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
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isObscurePassword =
                                                    !_isObscurePassword;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
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
                                            padding: const EdgeInsets.only(
                                                right: 10),
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
                                SizedBox(height: 20),
// Confirm new Password
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
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
                                      hintText: 'Confirm New Password',
                                      hintStyle: TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _isObscureConfirmPassword =
                                                    !_isObscureConfirmPassword;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
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
                                            padding: const EdgeInsets.only(
                                                right: 10),
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
                                SizedBox(height: 45),
//button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 255,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: _changePasswordValidation,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xFF449636)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                        ),
                                        child: Text(
                                          'Change Password',
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
                              ]))))
                ]))));
  }
}

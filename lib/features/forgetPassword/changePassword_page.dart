// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/login/login_page.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _hasText = false;
  bool _hasConfirmText = false;

  void _changePasswordValidation() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
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
//new Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                      padding: const EdgeInsets.only(right: 10),
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

// Confirm new Password
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                      padding: const EdgeInsets.only(right: 10),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF449636)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
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
          ])),
    );
  }
}

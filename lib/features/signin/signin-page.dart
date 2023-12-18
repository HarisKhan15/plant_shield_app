// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/home-page.dart';
import 'package:plant_shield_app/features/signup/signup-page.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscurePassword = true;
  bool _hasText = false; 

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
 //logo           
       Positioned(
         left: 43,
         child: Container(
         alignment: Alignment.center, 
         child: Image.asset('assets/logo.png',height: 300,
        ),
      ),
    ),    

//username and password  
  SingleChildScrollView(
     child: Container(
      padding: EdgeInsets.only(
      top: MediaQuery.of(context).size.height * 0.38,right: 10,left: 10),
      child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25),
             child: TextFormField(
             controller: _usernameController,
              validator: (value) {
               if (value == null || value.isEmpty) {
               return 'Please enter a username';
                }
                return null;
              },
               decoration: InputDecoration(
               contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              fillColor: Colors.grey.shade100,
              hintText: 'Username' ,
              hintStyle: TextStyle(fontSize: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
              suffixIcon: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/user.png'),
              ),
              filled: true,
                          ),
                        ),
                      ),
    SizedBox(height: 20),
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _passwordController,
              obscureText: _isObscurePassword,
              onChanged: (value) {
                setState(() {
                  _hasText = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                fillColor: Colors.grey.shade100,
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscurePassword = !_isObscurePassword;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          _hasText ? (_isObscurePassword ? Icons.visibility_off : Icons.visibility) : null,
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
                filled: true,
              ),
            ),
          ),

        // forget password
      Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 220), 
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forget Password?',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 10,
                color: Color(0xFFFF0000),
              ),
            ),
          ),
        ),
      ],
    ),

  SizedBox(height: 5),
//sign in button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
           width: 255, 
            height: 40,
            child: ElevatedButton(
            onPressed: _signIn,
              child: Text(
              'Sign in',
              style: TextStyle(
               color: Colors.white,
               fontSize: 18,
                fontWeight: FontWeight.w700, 
                        ),
                      ),
                    style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF449636)), 
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), 
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
                    height: 70,
                    ),
                  ),
                  Text('or',style: TextStyle(color: Color(0xFF58964D), fontSize: 16)),
                    Container(
                      width:150, 
                      child: Divider(
                          color: Colors.black,
                          thickness: 1,
                           height: 70,
                        ),
                      ), 
                    ], 
                  ),
//signin with
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Transform(
                    transform: Matrix4.translationValues(0, -20, 0), 
                    child: Text('Sign in with', style: TextStyle(fontSize: 12)),
                  ),
                ],
               ), 
// fb, google
           Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/fb.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 35,
                      height: 35,
                      child: Image.asset('assets/google.jpg'),
                    ),
                  ),
                ],
              ),
           
//dont have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xfff4c505b),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        child: Text(
                          'Sign up',
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
                ],
              ),
            ),
          )
              )
              ],
            )
          )
    );
  }
}


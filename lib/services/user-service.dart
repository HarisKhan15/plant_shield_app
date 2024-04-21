import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:plant_shield_app/models/update-password.dart';
import 'package:plant_shield_app/models/user-registration.dart';
import 'package:plant_shield_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  Future<User?> getLoggedInUser(String username) async {
    try {
      final response = await http.get(
        UrlConfig.buildUri('user/get-loggedin-user/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        User loggedInUser = User.fromJson(responseData);

        return loggedInUser;
      }
    } catch (e) {
      e.toString();
    }
    return null;
  }

  Future<http.Response?> loginUser(String username, String password) async {
    try {
      var requestBody = {
        "username": username,
        "password": password,
      };
      final response =
          await http.post(UrlConfig.buildUri("login"), body: requestBody);

      return response;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to log in. Please try again later.');
    }
  }

  Future<http.Response> registerUser(UserRegistration userRegistration) async {
    try {
      var requestBody = userRegistration.toForm();

      final response = await http.post(
        UrlConfig.buildUri("register"), // Replace with your actual endpoint
        body: requestBody,
      );

      return response;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to Sign in. Please try again later.');
    }
  }

  Future<http.Response?> validateUser(UserRegistration userRegistration) async {
    try {
      var request =
          http.MultipartRequest('GET', UrlConfig.buildUri('validate-new-user'));

      // Add additional form data
      request.fields.addAll(userRegistration.toFormValidate());

      final response = await http.Response.fromStream(await request.send());
      return response;
    } catch (e) {
      e.toString();
    }
    return null;
  }

  Future<http.Response?> checkUserByUsername(String username) async {
    try {
      final response = await http.get(
        UrlConfig.buildUri('/user/check-existence/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return response;
    } catch (e) {
      e.toString();
    }
    return null;
  }

  Future<http.Response> updatePassword(UpdatePassword updatePassword) async {
    try {
      var requestBody = updatePassword.toForm();

      final response = await http.put(
        UrlConfig.buildUri("/update/password"),
        body: requestBody,
      );
      return response;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to Sign in. Please try again later.');
    }
  }
  // Future<void> saveToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }

  // Future<String?> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }
}

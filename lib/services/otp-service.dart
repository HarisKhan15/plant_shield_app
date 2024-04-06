// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:plant_shield_app/models/verify-otp.dart';

class OTPService extends ChangeNotifier {
  Future<http.Response?> generateOTP(String email) async {
    try {
      var requestBody = {
        "user_email": email,
      };
      final response = await http.post(UrlConfig.buildUri("/generate-otp"),
          body: requestBody);

      return response;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to generate otp. Please try again later.');
    }
  }

  Future<http.Response?> otpVerification(VerifyOTP verifyOTPObject) async {
    try {
      var request =
          http.MultipartRequest('GET', UrlConfig.buildUri('verify-otp'));

      // Add additional form data
      request.fields.addAll(verifyOTPObject.toForm());

      final response = await http.Response.fromStream(await request.send());
      return response;
    } catch (e) {
      e.toString();
    }
    return null;
  }
}

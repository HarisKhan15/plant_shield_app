import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:plant_shield_app/models/profile.dart';
import 'package:http/http.dart' as http;

class ProfileService extends ChangeNotifier {
  Future<http.Response?> createProfile(File? imageFile, Profile profile) async {
    try {
      var request =
          http.MultipartRequest('POST', UrlConfig.buildUri('profile'));

      // Add image file to the request
      if (imageFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('file', imageFile.path));
      }

      // Add additional form data
      request.fields['username'] = profile.username;
      request.fields['first_name'] = profile.firstName;
      request.fields['last_name'] = profile.lastName;

      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to log in. Please try again later.');
    }
  }
}

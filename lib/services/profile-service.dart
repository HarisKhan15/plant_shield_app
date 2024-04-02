import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:plant_shield_app/models/edit-profile.dart';
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

  Future<EditProfile?> getProfileByUserName(String username) async {
    try {
      final response = await http.get(
        UrlConfig.buildUri('/profile/username/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        EditProfile profile = EditProfile.fromJson(responseData);

        return profile;
      }
    } catch (e) {
      e.toString();
    }
    return null;
  }

  Future<http.Response?> saveProfileData(
      File? imageFile, EditProfile editProfile) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        UrlConfig.buildUri('profile/${editProfile.id}'),
      );
      request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    request.fields.addAll(editProfile.toForm());
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'profile_picture', imageFile.path));
      }
      final response = await http.Response.fromStream(await request.send());
      return response;
    } catch (e) {
      print('Edit profile error: $e');
      throw Exception('Failed to edit profile data. Please try again later.');
    }
  }
}

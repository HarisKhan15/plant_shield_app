// ignore_for_file: file_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:plant_shield_app/models/create-user-plant.dart';
import 'package:plant_shield_app/models/plant-detection.dart';
import 'package:plant_shield_app/models/user-plant-detail.dart';
import 'package:plant_shield_app/models/user-plants.dart';

class UserPlantService extends ChangeNotifier {
  Future<PlantDetection?> detectPlantInformationAndDisease(
      File? imageFile) async {
    try {
      var request =
          http.MultipartRequest('GET', UrlConfig.buildUri('detect-plant'));

      if (imageFile != null) {
        request.files.add(
            await http.MultipartFile.fromPath('plant_image', imageFile.path));
      } else {
        return null;
      }

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return PlantDetection.fromJson(responseData);
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to find plant. Please try again later.');
    }
    return null;
  }

  Future<http.Response?> addDetectedPlantIntoUserPlant(
      File? imageFile, CreateUserPlant userPlant) async {
    try {
      var request =
          http.MultipartRequest('POST', UrlConfig.buildUri('user-plant'));

      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'user_plant_image', imageFile.path));
      }

      request.fields.addAll(userPlant.toForm());

      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to add user plant. Please try again later.');
    }
  }

  Future<http.Response?> fetchUserPlants(String username) async {
    try {
      final response =
          await http.get(UrlConfig.buildUri('user-plants/${username}'));

      return response;
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }

  Future<http.Response?> fetchSpecificUserPlant(
      String username, int userPlantId) async {
    try {
      final response = await http
          .get(UrlConfig.buildUri('user-plants/${username}/${userPlantId}'));
      return response;
    } catch (error) {
      print('Error: $error');
    }
    return null;
  }
}

// ignore_for_file: file_names, unnecessary_brace_in_string_interps
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_shield_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:plant_shield_app/models/feedback-model.dart';

class DetectionService extends ChangeNotifier {
  Future<FeedBackObject?> fetchUserPlants(int userPlantId) async {
    try {
      final response =
          await http.get(UrlConfig.buildUri('detections/${userPlantId}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        FeedBackObject feedBackObject = FeedBackObject.fromJson(data);
        return feedBackObject;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
    return null;
  }

  Future<http.Response?> updateFeedBack(
      int detectionId, bool isDetectionAccurate) async {
    try {
      Map<String, String> body = {
        'is_accurate_prediction': isDetectionAccurate.toString()
      };
      var request = http.MultipartRequest(
          'PUT', UrlConfig.buildUri('detections/${detectionId}'));

      request.fields.addAll(body);

      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to Update Feedback. Please try again later.');
    }
  }
}

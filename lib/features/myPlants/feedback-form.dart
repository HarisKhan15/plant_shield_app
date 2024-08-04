// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/services/detection_service.dart';

class FeedbackDialog extends StatefulWidget {
  final int detectionId;
  const FeedbackDialog({Key? key, required this.detectionId}) : super(key: key);

  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  bool? isWateringUpdateHelpful;
  bool? isDetectionAccurate;
  bool isSubmitting = false;
  bool isFieldsFilled = false;
  final DetectionService _detectionService = DetectionService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Feedback',
        style: TextStyle(
          fontFamily: 'Lato-Bold',
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Constants.primaryColor.withOpacity(0.9),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your feedback helps us grow and improve. Please take a moment to share your experience with us.',
              style: TextStyle(
                fontFamily: 'Lato-Bold',
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 10),
            Text('Is Watering Update Helpful?'),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isWateringUpdateHelpful,
                  onChanged: (value) {
                    setState(() {
                      isWateringUpdateHelpful = value;
                    });
                  },
                  activeColor: Constants.primaryColor,
                ),
                Text('Yes'),
                Radio<bool>(
                  value: false,
                  groupValue: isWateringUpdateHelpful,
                  onChanged: (value) {
                    setState(() {
                      isWateringUpdateHelpful = value;
                    });
                  },
                  activeColor: Constants.primaryColor,
                ),
                Text('No'),
              ],
            ),
            SizedBox(height: 10),
            Text('Is the plant disease detection accurate?'),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: isDetectionAccurate,
                  onChanged: (value) {
                    setState(() {
                      isDetectionAccurate = value;
                    });
                  },
                  activeColor: Constants.primaryColor,
                ),
                Text('Yes'),
                Radio<bool>(
                  value: false,
                  groupValue: isDetectionAccurate,
                  onChanged: (value) {
                    setState(() {
                      isDetectionAccurate = value;
                    });
                  },
                  activeColor: Constants.primaryColor,
                ),
                Text('No'),
              ],
            ),
            Row(
              children: [
                isFieldsFilled
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Please fill both fields.',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              color: Constants.primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: isSubmitting
              ? null
              : () {
                  if (isDetectionAccurate == null ||
                      isWateringUpdateHelpful == null) {
                    setState(() {
                      isFieldsFilled = true;
                    });
                  } else {
                    submitFeedback();
                  }
                },
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: 15,
              color: Constants.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  void submitFeedback() {
    setState(() {
      isSubmitting = true;
    });
    updateFeedBack();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isSubmitting = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Feedback submitted!'),
          backgroundColor: Constants.primaryColor,
        ),
      );
    });
  }

  void updateFeedBack() async {
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);

      response = await _detectionService.updateFeedBack(
          widget.detectionId, isDetectionAccurate!);

      if (response != null && response.statusCode == 200) {
        return;
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
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  bool? isWateringUpdateHelpful;
  bool? isDetectionAccurate;
  bool isSubmitting = false;

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
                  submitFeedback();
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
    Future.delayed(Duration(seconds: 2), () {
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
}

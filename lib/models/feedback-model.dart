import 'dart:io';

class FeedBackObject {
  int detectionId;
  bool isFeedBackRequired;

  FeedBackObject({
    this.detectionId = -1,
    this.isFeedBackRequired = false,
  });

  factory FeedBackObject.fromJson(Map<String, dynamic> json) {
    return FeedBackObject(
      detectionId: json['detetion_id'] ?? -1,
      isFeedBackRequired: json['feedback'] ?? false,
    );
  }
}

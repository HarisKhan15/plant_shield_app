import 'dart:io';

class UserPlantDetail {
  int userPlantId;
  String userPlantImage;
  DateTime? lastWatered;
  DateTime? dateAdded;

  UserPlantDetail(
      {this.userPlantId = -1,
      this.userPlantImage = '',
      this.lastWatered,
      this.dateAdded});

  factory UserPlantDetail.fromJson(Map<String, dynamic> json) {
    return UserPlantDetail(
      userPlantId: json['id'] ?? 0,
      userPlantImage: json['user_plant_image'] ?? '',
      lastWatered: json['last_watered'] != null
          ? DateTime.parse(
                  HttpDate.parse(json['last_watered']).toIso8601String())
              .add(const Duration(hours: 5))
          : null,
      dateAdded: json['date_added'] != null
          ? DateTime.parse(HttpDate.parse(json['date_added']).toIso8601String())
              .add(const Duration(hours: 5))
          : null,
    );
  }
}

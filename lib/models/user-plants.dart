import 'dart:io';

class UserPlant {
  int userPlantId;
  String plantName;
  String species;
  String wateringSchedule;
  String userPlantImage;
  String currentDisease;
  DateTime lastWatered;
  bool isOverDue = true;

  UserPlant({
    this.userPlantId = -1,
    this.plantName = '',
    this.species = '',
    this.wateringSchedule = '',
    this.userPlantImage = '',
    this.currentDisease = '',
    required this.lastWatered,
  });

  factory UserPlant.fromJson(Map<String, dynamic> json) {
    return UserPlant(
      userPlantId: json['id'],
      plantName: json['plant_name'],
      species: json['species'],
      wateringSchedule: json['watering_schedule'],
      userPlantImage: json['user_plant_image'],
      currentDisease: json['current_disease'],
      lastWatered: DateTime.parse(
          HttpDate.parse(json['last_watered']).toIso8601String()),
    );
  }
}

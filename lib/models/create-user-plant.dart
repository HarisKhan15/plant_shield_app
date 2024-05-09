class CreateUserPlant {
  String username;
  int plantId;
  String currentDisease;

  CreateUserPlant({
    this.username = '',
    this.plantId = -1,
    this.currentDisease = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'plant_id': plantId,
      'current_disease': currentDisease,
    };
  }

  factory CreateUserPlant.fromJson(Map<String, dynamic> json) {
    return CreateUserPlant(
      username: json['username'] ?? '',
      plantId: json['plant_id'] ?? '',
      currentDisease: json['current_disease'] ?? '',
    );
  }

  Map<String, String> toForm() {
    return {
      'username': username,
      'plant_id': plantId.toString(),
      'current_disease': currentDisease
    };
  }
}

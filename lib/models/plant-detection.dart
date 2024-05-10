class PlantDetection {
  int plantId;
  String plantName;
  String description;
  String species;
  String speciesDetail;
  String maxLife;
  String wateringSchedule;
  String wateringScheduleDetail;
  String sunlightRequirements;
  String sunlightRequirementsDetail;
  String temperatureRequirements;
  String temperatureRequirementsDetail;
  String humidity;
  String humidityDetail;
  String notes;
  String diseaseName;
  String diseaseDescription;
  String diseasePossibleSteps;

  PlantDetection({
    this.plantId = -1,
    this.plantName = '',
    this.description = '',
    this.species = '',
    this.speciesDetail = '',
    this.maxLife = '',
    this.wateringSchedule = '',
    this.wateringScheduleDetail = '',
    this.sunlightRequirements = '',
    this.sunlightRequirementsDetail = '',
    this.temperatureRequirements = '',
    this.temperatureRequirementsDetail = '',
    this.humidity = '',
    this.humidityDetail = '',
    this.notes = '',
    this.diseaseName = '',
    this.diseaseDescription = '',
    this.diseasePossibleSteps = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'plant_id': plantId,
      'plant_name': plantName,
      'description': description,
      'species': species,
      'species_detail': speciesDetail,
      'max_life': maxLife,
      'watering_schedule': wateringSchedule,
      'watering_schedule_detail': wateringScheduleDetail,
      'sunlight_requirements': sunlightRequirements,
      'sunlight_requirements_detail': sunlightRequirementsDetail,
      'temperature_requirements': temperatureRequirements,
      'temperature_requirements_detail': temperatureRequirementsDetail,
      'humidity': humidity,
      'humidity_detail': humidityDetail,
      'notes': notes,
      'disease_name': diseaseName,
      'disease_description': diseaseDescription,
      'disease_possible_steps': diseasePossibleSteps,
    };
  }

  factory PlantDetection.fromJson(Map<String, dynamic> json) {
    return PlantDetection(
      plantId: json['plant_id'] ?? 0,
      plantName: json['plant_name'] ?? '',
      description: json['description'] ?? '',
      species: json['species'] ?? '',
      speciesDetail: json['species_detail'] ?? '',
      maxLife: json['max_life'] ?? '',
      wateringSchedule: json['watering_schedule'] ?? '',
      wateringScheduleDetail: json['watering_schedule_detail'] ?? '',
      sunlightRequirements: json['sunlight_requirements'] ?? '',
      sunlightRequirementsDetail: json['sunlight_requirements_detail'] ?? '',
      temperatureRequirements: json['temperature_requirements'] ?? '',
      temperatureRequirementsDetail: json['temperature_requirements_detail'] ?? '',
      humidity: json['humidity'] ?? '',
      humidityDetail: json['humidity_detail'] ?? '',
      notes: json['notes'] ?? '',
      diseaseName: json['disease_name'] ?? '',
      diseaseDescription: json['disease_description'] ?? '',
      diseasePossibleSteps: json['disease_possible_steps'] ?? '',
    );
  }

  Map<String, dynamic> toForm() {
    return {
      'plant_id': plantId.toString(),
      'plant_name': plantName,
      'description': description,
      'species': species,
      'species_detail': speciesDetail,
      'max_life': maxLife,
      'watering_schedule': wateringSchedule,
      'watering_schedule_detail': wateringScheduleDetail,
      'sunlight_requirements': sunlightRequirements,
      'sunlight_requirements_detail': sunlightRequirementsDetail,
      'temperature_requirements': temperatureRequirements,
      'temperature_requirements_detail': temperatureRequirementsDetail,
      'humidity': humidity,
      'humidity_detail': humidityDetail,
      'notes': notes,
      'disease_name': diseaseName,
      'disease_description': diseaseDescription,
      'disease_possible_steps': diseasePossibleSteps,
    };
  }
}
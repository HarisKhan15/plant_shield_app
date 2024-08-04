class ImageModel {
  int id;
  String data; // Assuming base64-encoded binary data
  String imageName;
  String imageExtension;
  int entityId;
  int entityTypeId;
  String createdDate;

  ImageModel({
    required this.id,
    required this.data,
    required this.imageName,
    required this.imageExtension,
    required this.entityId,
    required this.entityTypeId,
    required this.createdDate,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      data: json['data'],
      imageName: json['image_name'],
      imageExtension: json['image_extension'],
      entityId: json['entity_id'],
      entityTypeId: json['entity_type_id'],
      createdDate: json['created_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data,
      'image_name': imageName,
      'image_extension': imageExtension,
      'entity_id': entityId,
      'entity_type_id': entityTypeId,
      'created_date': createdDate,
    };
  }
}
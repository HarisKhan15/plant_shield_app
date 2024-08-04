class EditProfile {
  int id;
  String firstName;
  String lastName;
  String bio;
  String gender;
  String phoneNumber;
  String location;
  String profilePicture;

  EditProfile(
      {this.id = -1,
      this.firstName = '',
      this.lastName = '',
      this.bio = '',
      this.gender = '',
      this.phoneNumber = '',
      this.location = '',
      this.profilePicture = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_Name': firstName,
      'last_Name': lastName,
      'bio': bio,
      'gender': gender,
      'phone': phoneNumber,
      'location': location,
      'profile_Picture': profilePicture
    };
  }

  factory EditProfile.fromJson(Map<String, dynamic> json) {
    return EditProfile(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      phoneNumber: json['phone'] ?? '',
      location: json['location'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }
  Map<String, String> toForm() {
    return {
      'id': id.toString(),
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'gender': gender,
      'phone': phoneNumber,
      'location': location,
      'profile_picture': profilePicture,
    };
  }
}

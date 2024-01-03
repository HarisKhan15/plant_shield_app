class Profile {
  String firstName;
  String lastName;
  String bio;
  String gender;
  String phone;
  String location;
  String username;

  Profile(
      {
      this.firstName = '',
      this.lastName = '',
      this.bio = '',
      this.gender = '',
      this.phone = '',
      this.location = '',
      this.username = '',});

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'gender': gender,
      'phone': phone,
      'location': location,
      'username': username,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

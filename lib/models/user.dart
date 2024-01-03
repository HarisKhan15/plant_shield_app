class User {
  String firstName;
  String lastName;
  String email;
  String username;

  User(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.username = ''});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

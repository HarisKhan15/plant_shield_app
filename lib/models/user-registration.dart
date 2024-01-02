class UserRegistration {
  String email;
  String username;
  String password;

  UserRegistration(this.email, this.username, this.password);

  Map<String, dynamic> toForm() {
    return {'email': email, 'username': username, 'password': password};
  }
}

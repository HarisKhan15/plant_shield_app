class UserRegistration {
  String email;
  String username;
  String password;
  String deviceToken;

  UserRegistration(this.email, this.username, this.password,this.deviceToken);

  Map<String, dynamic> toForm() {
    return {'email': email, 'username': username, 'password': password,'device_token':deviceToken};
  }

  Map<String, String> toFormValidate() {
    return {'email': email, 'username': username, 'password': password};
  }
}

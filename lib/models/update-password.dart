class UpdatePassword {
  String username;
  String password;

  UpdatePassword( this.username, 
                  this.password);
        
  Map<String, String> toForm() {
    return {
      'username': username.toString(),
      'new_password': password,
    };
  }
}

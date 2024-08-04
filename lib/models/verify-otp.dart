class VerifyOTP {
  String email;
  int otp;

  VerifyOTP({this.otp = -1,
        this.email = '',});
        
  factory VerifyOTP.fromJson(Map<String, dynamic> json) {
    return VerifyOTP(
      otp: json['otp'] ?? '',
      email: json['user_email'] ?? '',
    );
  }
  Map<String, String> toForm() {
    return {
      'otp': otp.toString(),
      'user_email': email,
    };
  }
}

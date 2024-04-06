class GeneratedOTP {
  String email;
  String timestamp;
  int otp;

  GeneratedOTP(
        {this.otp = -1,
        this.timestamp = '',
        this.email = '',});
        
  factory GeneratedOTP.fromJson(Map<String, dynamic> json) {
    return GeneratedOTP(
      otp: json['otp'] ?? '',
      timestamp: json['timestamp'] ?? '',
      email: json['user_email'] ?? '',
    );
  }
}

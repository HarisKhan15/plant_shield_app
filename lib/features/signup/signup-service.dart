import 'dart:convert';

import 'package:http/http.dart' as http;


String baseUrl = 'https://c14b-58-27-134-33.ngrok-free.app';

Future<String> registerUser(String email,String username, String password) async {
  var requestBody = {
    "email": email,
    "username": username, 
    "password": password,
  };

  final response = await http.post(
    Uri.parse(
        '$baseUrl/register'), // Replace with your actual endpoint
    body: requestBody,
  );

  if (response.statusCode == 200) {
    return "OK"; // Successful authentication
  } else {
    return response.body; // Failed authentication
  }
}

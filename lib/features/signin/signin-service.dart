import 'package:http/http.dart' as http;

Future<bool> fetchAlbum(String username, String password) async {
  var requestBody = {
    "username": username,
    "password": password,
  };

  final response = await http.post(
    Uri.parse(
        'https://58a1-58-27-134-33.ngrok-free.app/signin'), // Replace with your actual endpoint
    body: requestBody,
  );

  if (response.statusCode == 200) {
    return true; // Successful authentication
  } else {
    return false; // Failed authentication
  }
}

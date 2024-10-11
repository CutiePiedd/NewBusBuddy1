import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminApi {
  static const String _baseUrl =
      'http://localhost/newdatabase'; // Update this if using a different URL

  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$_baseUrl/admin_login.php');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
      },
    );

    print(response.body); // Log the response body for debugging

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print('Response Body: $responseBody');
      return responseBody['success'] == true;
    } else {
      throw Exception('Failed to login user');
    }
  }
}

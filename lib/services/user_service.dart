import 'dart:convert';
import 'dart:io';

class UserService {
  final String baseUrl;

  UserService({required this.baseUrl});

  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<bool> createUser(String username, String password) async {
    final request = await client.postUrl(Uri.parse(baseUrl));

    request.headers.set('Content-Type', 'application/json');
    final jsonBody = jsonEncode({
      'username': username,
      'password': password,
    });
    request.write(jsonBody);

    try {
      final response = await request.close();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

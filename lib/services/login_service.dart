import 'dart:convert';
import 'dart:io';

import 'package:mcbike/auth/auth_service.dart';

class LoginService {
  final String baseUrl;

  LoginService({required this.baseUrl});

  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<bool> login(String username, String password) async {
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
        final responseData =
            json.decode(await response.transform(utf8.decoder).join());
        final token = responseData['token'];
        AuthService.setToken(token);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

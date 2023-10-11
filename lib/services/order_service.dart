import 'dart:convert';
import 'dart:io';

import 'package:mcbike/provider/cart_provider.dart';

class OrderService {
  final String baseUrl;

  OrderService({required this.baseUrl});

  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<bool> createOrder(int userId) async {
    final request = await client.postUrl(Uri.parse(baseUrl));

    request.headers.set('Content-Type', 'application/json');
    final jsonBody = userId;
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

  Future<bool> createOrderItems(List<CartItem> cartItems) async {
    String jsonBody = "";
    final request = await client.postUrl(Uri.parse("$baseUrl/item"));

    request.headers.set('Content-Type', 'application/json');
    for (CartItem item in cartItems) {
      jsonBody += jsonEncode({'orderId': item.,
      ''});
    }

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

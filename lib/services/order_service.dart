import 'dart:convert';
import 'dart:io';

import 'package:mcbike/auth/auth_service.dart';
import 'package:mcbike/provider/cart_provider.dart';

class OrderService {
  final String baseUrl;

  OrderService({required this.baseUrl});

  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<int> createOrder(int userId) async {
    final request = await client.postUrl(Uri.parse(baseUrl));

    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer ${AuthService.jwtToken}');
    final jsonBody = userId;
    request.write(jsonBody);

    try {
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseData =
            json.decode(await response.transform(utf8.decoder).join());
        final orderId = responseData['orderId'];

        return orderId;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  Future<bool> createOrderItems(List<CartItem> cartItems, int orderId) async {
    final request = await client.postUrl(Uri.parse("$baseUrl/item"));

    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer ${AuthService.jwtToken}');

    final List<Map<String, dynamic>> itemsList = cartItems.map((item) {
      return {
        'orderId': orderId,
        'productId': item.product.id,
        'productQty': item.quantity,
      };
    }).toList();

    final jsonBody = jsonEncode(itemsList);

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

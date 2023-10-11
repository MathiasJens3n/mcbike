import 'dart:convert';
import 'dart:io';
import 'package:mcbike/models/product.dart';

class CartApiService {
  final String baseUrl;

  CartApiService({required this.baseUrl});

  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<bool> addToCart(Product product) async {
    final request = await client.postUrl(Uri.parse(baseUrl));

// Convert images to JSON-serializable list
    final List<Map<String, dynamic>> imagesJson = product.images.map((image) {
      return {
        'id': image.id,
        'productId': image.productId,
        'base64': image.base64,
        'name': image.name,
      };
    }).toList();

    // Convert specifications to JSON-serializable list
    final List<Map<String, dynamic>> specificationsJson =
        product.specifications.map((spec) {
      return {
        'id': spec.id,
        'productId': spec.productId,
        'name': spec.name,
        'specDescription': spec.specDescription,
      };
    }).toList();

    request.headers.set('Content-Type', 'application/json');
    final jsonBody = jsonEncode({
      'name': product.name,
      'category': product.category,
      'quantity': product.quantity,
      'price': product.price,
      'description': product.description,
      'images': imagesJson,
      'specifications': specificationsJson
    });
    print(jsonBody);
    request.write(jsonBody);

    try {
      final response = await request.close();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final request = await client.getUrl(
      Uri.parse(baseUrl),
    );
    request.headers.set('Content-Type', 'application/json');

    final response = await request.close();

    if (response.statusCode == 200) {
      List responseData =
          json.decode(await response.transform(utf8.decoder).join());
      final products =
          responseData.map((product) => Product.fromJson(product)).toList();
      // Return the list of products
      return products;
    } else {
      throw Exception('Failed to load products from API');
    }
  }
  // Future<bool> removeFromCart() async {}
}

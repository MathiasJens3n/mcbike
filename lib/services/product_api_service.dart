import 'dart:convert';
import 'dart:io';
import 'package:mcbike/models/product.dart';

class ProductApiService {
  final String baseUrl;
  final bool useMockData;

  ProductApiService({required this.baseUrl, this.useMockData = true});
  // Http client
  final HttpClient client = HttpClient()
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final request = await client.getUrl(Uri.parse('$baseUrl/category')
        .replace(queryParameters: {'category': category}));
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

  Future<Product> fetchProductsById(int id) async {
    final request = await client.getUrl(Uri.parse('$baseUrl/$id'));
    request.headers.set('Content-Type', 'application/json');

    final response = await request.close();

    if (response.statusCode == 200) {
      final responseData =
          json.decode(await response.transform(utf8.decoder).join());
      return Product.fromJson(responseData);
    } else {
      throw Exception('Failed to load products from API');
    }
  }
}

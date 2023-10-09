import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mcbike/models/product.dart';

class ProductService {
  final String baseUrl;
  final bool useMockData;

  ProductService({required this.baseUrl, this.useMockData = false});

  Future<void> fetchProducts() async {
    if (useMockData) {
      // return DataService().loadMockData();
    }

    final response = await http.get(Uri.parse('$baseUrl/1'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse.map((product) => Product.fromJson(product)).toList());
      // return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products from API');
    }
  }
}

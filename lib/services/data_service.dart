import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mcbike/models/product.dart';

class DataService {
  Future<List<Product>> loadMockData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/mock_products.json');
      final List<dynamic> decodedData = json.decode(jsonString);
      return decodedData.map((json) => Product.fromJson(json)).toList();
    } catch (error) {
      // Handle any errors that occur while loading mock data.
      return []; // Return an empty list as a fallback.
    }
  }
}
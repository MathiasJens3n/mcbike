import 'package:mcbike/models/image.dart';

import 'Specification.dart';

class Product {
  int id;
  int category;
  int quantity;
  String name;
  int price;
  String description;
  List<Image> images;
  List<Specification> specifications;

  Product({
    required this.id,
    required this.category,
    required this.quantity,
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> imagesJson =
        (json['images'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
    final List<Map<String, dynamic>> specificationsJson =
        (json['specifications'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>() ??
            [];
    final List<Image> imagesList = imagesJson.map((imageJson) {
      return Image(
        id: imageJson['id'] as int,
        productId: imageJson['productId'] as int,
        base64: imageJson['base64'] as String,
        name: imageJson['name'] as String,
      );
    }).toList();

    final List<Specification> specificationsList =
        specificationsJson.map((specJson) {
      return Specification(
        id: specJson['id'] as int,
        productId: specJson['productId'] as int,
        name: specJson['name'] as String,
        specDescription: specJson['specDescription'] as String,
      );
    }).toList();

    return Product(
      id: json['id'] as int,
      category: json['category'] as int,
      quantity: json['quantity'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      images: imagesList,
      specifications: specificationsList,
    );
  }
}

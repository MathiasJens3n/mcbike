class Product {
  final int id;
  final String name;
  final String description;

  Product({required this.id, required this.name, required this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

// C:\mcbike\lib\repositories\mock_data.dart

class Category {
  final String name;

  Category({required this.name});
}

class Product {
  final int id;
  final String name;
  final String description;
  final Category category;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });
}

class MockData {
  static List<Category> categories = [
    Category(name: "Bikes"),
    Category(name: "Gear"),
    Category(name: "Accessories"),
    Category(name: "Parts"),
    Category(name: "Riding Kits"),
  ];

  static List<Product> products = [
    Product(
      id: 1001,
      name: "X-Rider 250cc Pro",
      description: "A top-of-the-line 250cc motocross bike designed for enthusiasts seeking the ultimate thrill. Lightweight frame, powerful engine, and unmatched suspension.",
      category: categories[0],
      price: 37500.50,
    ),
    Product(
      id: 1002,
      name: "DirtMaster 125cc Junior",
      description: "Perfect for beginners and young riders. The DirtMaster 125cc provides a balanced mix of power and control.",
      category: categories[0],
      price: 18750.75,
    ),
    Product(
      id: 1003,
      name: "TrailGuard Helmet",
      description: "A state-of-the-art helmet designed for rugged trails. Features include maximum ventilation, a detachable visor, and superior impact resistance.",
      category: categories[1],
      price: 1250.25,
    ),
    Product(
      id: 1004,
      name: "Stealth Gloves",
      description: "High-grip gloves perfect for maintaining control during intense rides. Breathable fabric ensures comfort.",
      category: categories[1],
      price: 300.45,
    ),
    Product(
      id: 1005,
      name: "Enduro Boots",
      description: "Boots crafted for challenging terrains. Provides ankle support, toe protection, and waterproof features.",
      category: categories[1],
      price: 2700.85,
    ),
  ];
}

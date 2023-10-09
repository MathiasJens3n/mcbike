import 'package:flutter/material.dart';
import 'package:mcbike/repositories/mock_data.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('path_to_product_image'), // husk at ændre
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Price: ${product.price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add the product to the cart
                // Implement this logic using CartProvider
                // Example: CartProvider().addToCart(product);

                // Show a popup with a message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Product Added to Cart"),
                    content: Text("${product.name} has been added to your cart."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the popup
                        },
                        child: Text("Keep Shopping"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the cart page
                          Navigator.of(context).pushNamed('/cart'); // define the '/cart' route in main.dart
                        },
                        child: Text("Go to Cart"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

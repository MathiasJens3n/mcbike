import 'package:flutter/material.dart';
import 'package:mcbike/models/product.dart';
import 'package:mcbike/pages/cart_page.dart';
import 'package:mcbike/provider/cart_provider.dart';
import 'package:mcbike/services/cart_api_service.dart';
import 'package:mcbike/widgets/shoppingcart_appbar.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final CartApiService cartApiService =
      CartApiService(baseUrl: "https://192.168.56.1:5000/api/shoppingcart");

  ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      appBar: const ShoppingCartAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/motocb4.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ${product.price}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Add the product to the cart
                // Implement this logic using CartProvider
                // Example: CartProvider().addToCart(product);
                // Show a popup with a message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Product Added to Cart"),
                    content:
                        Text("${product.name} has been added to your cart."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the popup
                        },
                        child: const Text("Keep Shopping"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the cart page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()),
                          );
                        },
                        child: const Text("Go to Cart"),
                      ),
                    ],
                  ),
                );
                bool succes = await cartApiService.addToCart(product);

                if (succes) {
                  cartProvider.addToCart(product);
                }
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

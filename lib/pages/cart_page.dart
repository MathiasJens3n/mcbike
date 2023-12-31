import 'package:flutter/material.dart';
import 'package:mcbike/auth/auth_service.dart';
import 'package:mcbike/auth/claims_service.dart';
import 'package:mcbike/pages/products_page.dart';
import 'package:mcbike/provider/cart_provider.dart';
import 'package:mcbike/services/order_service.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  final claimService = ClaimService();
  final orderService =
      OrderService(baseUrl: "https://192.168.56.1:5000/api/order");
  final isUserLoggedIn = AuthService.jwtToken != null ? true : false;

  CartPage({Key? key}) : super(key: key);

  Future<void> _showOrderConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank you for the order!'),
          content: const Text('Your order has been placed successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to another screen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductPage(),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true, // Add this line
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cart.cartItems[index];
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset("assets/motocb2.png"),
                      title: Text(item.product.name),
                      subtitle: Text(item.product.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.removeFromCart(item.product);
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartProvider.addToCart(item.product);
                            },
                          ),
                          const SizedBox(width: 8),
                          Text("${item.product.price * item.quantity}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Visibility(
                visible: isUserLoggedIn,
                child: ElevatedButton(
                  onPressed: () async {
                    int orderId =
                        await orderService.createOrder(claimService.userID);
                    if (orderId != -1) {
                      if (await orderService.createOrderItems(
                          cart.cartItems, orderId)) {
                        // ignore: use_build_context_synchronously
                        _showOrderConfirmationDialog(context);
                        cartProvider.cartItems.clear();
                      }
                    } else {
                      // Handle the case where orderId is -1
                    }
                  },
                  child: const Text('Order'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

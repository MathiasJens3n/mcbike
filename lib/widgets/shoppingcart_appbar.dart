import 'package:flutter/material.dart';
import 'package:mcbike/pages/cart_page.dart';
import 'package:mcbike/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ShoppingCartAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        int itemCount = cartProvider.cartItems.length;
        return AppBar(
          title: const Text("Viking Motocross"),
          centerTitle: true,
          elevation: 0,
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartPage()),
                      );
                    }),
                itemCount > 0
                    ? Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        );
      },
    );
  }
}

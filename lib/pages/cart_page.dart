import 'package:flutter/material.dart';

import 'package:mcbike/provider/cart_provider.dart';
import 'package:provider/provider.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }
          return ListView.builder(
            itemCount: cart.cartItems.length,
            itemBuilder: (context, index) {
              final item = cart.cartItems[index];
              return ListTile(
                title: Text(item.product.name),
                subtitle: Text('${item.product.description}'),
                // trailing: Text('${item.product.price} x ${item.quantity}'),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mcbike/models/product.dart';
import 'package:mcbike/repositories/mock_data.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  // Add a product to the cart
  void addToCart(Product product) {
    for (CartItem item in _cartItems) {
      if (item.product.id == product.id) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    _cartItems.add(CartItem(product: product, quantity: 1));
    notifyListeners();
  }

  // Remove a product from the cart
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // Calculate the total price of items in the cart
  double getTotalPrice() {
    double total = 0;
    for (CartItem item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}

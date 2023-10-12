import 'package:mcbike/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  int orderId;

  CartItem(
      {required this.product, required this.quantity, required this.orderId});
}

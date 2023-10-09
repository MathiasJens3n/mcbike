import 'package:mcbike/repositories/mock_data.dart';

import 'package:mcbike/app_colors.dart';

import 'package:mcbike/models/product.dart';
import  'package:mcbike/models/cart_item.dart';


class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

import 'package:flutter/material.dart';
import 'package:mcbike/models/product.dart';

class ProductProvider extends ChangeNotifier{
  List<Product> productList = [];

  void addProducts(List<Product> products){
    productList.addAll(products);
    notifyListeners();
  }
}
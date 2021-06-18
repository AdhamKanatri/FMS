import 'package:test_fms/models/products.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Products> products = [];
  addProduct(Products product) {
    products.add(product);
    notifyListeners();
  }
  deleteProduct(Products product) {
    products.remove(product);
    notifyListeners();
  }
}

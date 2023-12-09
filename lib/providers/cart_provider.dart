import 'package:flutter/material.dart';

import 'package:pinetech/models/product.dart';

import '../models/category.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartProduct = [];
  Category? selectedCategory;

  bool addOrRemoveProduct(Product product) {
    if (canAddProduct()) {
      if (cartProduct.where((element) => element.id == product.id).isNotEmpty) {
        cartProduct.removeWhere(
          (element) => element.id == product.id,
        );
      } else {
        cartProduct.add(product);
      }
      print(cartProduct);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool canAddProduct() {
    if (cartProduct.length < 6) {
      return true;
    } else {
      return false;
    }
  }
}

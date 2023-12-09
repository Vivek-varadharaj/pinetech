import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinetech/models/product.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/repositories/api_repository.dart';
import 'package:pinetech/services/network_services.dart';
import 'package:pinetech/utils/app_constants.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  late ApiRepository _apiRepository;
  List<Product> products = [];
  bool isLoading = false;

  ProductProvider() {
    _apiRepository = ApiRepository(apiService: ApiService(baseUrl: baseUrl));
  }

  void getProducts(String category) async {
    isLoading = true;
    notifyListeners();
    Response response = await _apiRepository.fetchProductsByCategory(category);
    if (response.statusCode == 200) {
      List<dynamic> tempResponse = json.decode(response.body)["products"];

      products = tempResponse.map((e) => Product.fromJson(e)).toList();
      print(products);
    }
    isLoading = false;
    notifyListeners();
  }
}

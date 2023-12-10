import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinetech/models/product.dart';
import 'package:pinetech/repositories/api_repository.dart';
import 'package:pinetech/services/network_services.dart';
import 'package:pinetech/utils/app_constants.dart';

class ProductProvider extends ChangeNotifier {
  late ApiRepository _apiRepository;
  List<Product> products = [];
  bool isLoading = true;

  ProductProvider() {
    _apiRepository = ApiRepository(apiService: ApiService(baseUrl: baseUrl));
  }

  Future<ResponseModel> getProducts(String category) async {
    isLoading = true;
    notifyListeners();
    try {
      Response response =
          await _apiRepository.fetchProductsByCategory(category);
      if (response.statusCode == 200) {
        List<dynamic> tempResponse = json.decode(response.body)["products"];

        products = tempResponse.map((e) => Product.fromJson(e)).toList();
        isLoading = false;
        notifyListeners();
        return ResponseModel(true, "success");
      } else {
        isLoading = false;
        notifyListeners();
        return ResponseModel(false, "Network call failed");
      }
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  Future<ResponseModel> fetchProductsByCategory(String category) async {
    isLoading = true;
    notifyListeners();
    try {
      Response response =
          await _apiRepository.fetchProductsByCategory(category);
      if (response.statusCode == 200) {
        List<dynamic> tempResponse = json.decode(response.body);

        products = tempResponse.map((e) => Product.fromJson(e)).toList();
        isLoading = false;

        notifyListeners();
        return ResponseModel(true, "success");
      } else {
        isLoading = false;
        notifyListeners();
        return ResponseModel(false, "Network call failed");
      }
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }
}

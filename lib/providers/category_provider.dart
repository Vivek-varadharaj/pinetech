import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinetech/repositories/api_repository.dart';
import 'package:pinetech/services/network_services.dart';
import 'package:pinetech/utils/app_constants.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  late ApiRepository _apiRepository;
  List<Category> categories = [];
  Category? selectedCategory;
  bool isLoading = false;

  CategoryProvider() {
    _apiRepository = ApiRepository(apiService: ApiService(baseUrl: baseUrl));
  }

  Future<ResponseModel> getCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      Response response = await _apiRepository.fetchCategories();
      if (response.statusCode == 200) {
        List<dynamic> tempResponse = json.decode(response.body);

        categories = tempResponse.map((e) => Category.fromJson(e)).toList();
        isLoading = false;

        notifyListeners();
        return ResponseModel(true, "success");
      } else {
        isLoading = false;
        notifyListeners();
        return ResponseModel(false, "Network call failed");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return ResponseModel(false, e.toString());
    }
  }

  void setSelectedCategory(Category category) {
    selectedCategory = category;
  }
}

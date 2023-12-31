import 'package:http/http.dart';

import 'package:pinetech/services/network_services.dart';
import 'package:pinetech/utils/app_constants.dart';

class ApiRepository {
  ApiService apiService;
  ApiRepository({required this.apiService});

  Future<Response> fetchCategories() async {
    return await apiService.get(getAllCategoryUrl);
  }

  Future<Response> fetchProductsByCategory(String categoryId) async {
    // Implement API call to fetch products by category
    return await apiService.get("$getProductsFromCategory/$categoryId");
  }
}

class ResponseModel {
  final bool _isSuccess;
  final String _message;

  ResponseModel(
    this._isSuccess,
    this._message,
  );

  String get message => _message;
  bool get isSuccess => _isSuccess;
}

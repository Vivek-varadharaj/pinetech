import 'package:http/http.dart';
import 'package:pinetech/models/category.dart';
import 'package:pinetech/models/product.dart';

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
return await apiService.get(getProductsFromCategory + "/$categoryId");

    throw UnimplementedError();
  }
}

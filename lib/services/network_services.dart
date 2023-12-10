import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;


class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    log("$baseUrl/$endpoint");

    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return response;
  }
}



 
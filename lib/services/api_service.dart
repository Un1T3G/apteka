import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/product.dart';

class ApiService {
  static const baseUrl = 'https://apteka-server.vercel.app/api';

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/category'));
    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Product>> fetchProducts({
    String? searchQuery,
    int? categoryId,
  }) async {
    final queryParams = <String, String>{};
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['search'] = searchQuery;
    }
    if (categoryId != null) {
      queryParams['categoryId'] = categoryId.toString();
    }

    final uri = Uri.parse(
      '$baseUrl/products',
    ).replace(queryParameters: queryParams);
    final response = await http.get(uri);

    print(uri);

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  static Future<List<Product>> fetchProductByCategoryId(int categoryId) async {
    return fetchProducts(categoryId: categoryId);
  }
}

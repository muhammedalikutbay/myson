import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myson/data/models/product.dart';

class ProductService {
  static List<Map<String, dynamic>> _rawData = [];

  static Future<void> init() async {
    if (_rawData.isNotEmpty) return;
    try {
      final String response = await rootBundle.loadString(
        'assets/data/products.json',
      );
      final List<dynamic> data = json.decode(response);
      _rawData = data.cast<Map<String, dynamic>>();
    } catch (e) {
      // Fallback or empty list
      _rawData = [];
    }
  }

  static Future<List<Product>> getProducts({
    String? query,
    String? category,
  }) async {
    await init();
    Iterable<Map<String, dynamic>> data = _rawData;

    if (category != null && category != 'All Products') {
      data = data.where((item) => item['category'] == category);
    }

    if (query != null && query.isNotEmpty) {
      final lowercaseQuery = query.toLowerCase();
      data = data.where(
        (item) =>
            item['name'].toLowerCase().contains(lowercaseQuery) ||
            item['description'].toLowerCase().contains(lowercaseQuery),
      );
    }

    return data.map((json) => Product.fromMap(json)).toList();
  }

  static List<String> getCategories() {
    return ['All Products', 'Vacuums', 'Hair Care', 'Air Quality'];
  }
}

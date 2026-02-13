import 'package:flutter/material.dart';
import 'package:myson/data/repositories/i_product_repository.dart';
import 'package:myson/data/models/product.dart';

class CatalogViewModel extends ChangeNotifier {
  final IProductRepository _repository;

  CatalogViewModel(this._repository) {
    fetchProducts();
  }

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _selectedCategory = 'All Products';
  String get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<String> get categories => _repository.getCategories();

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await _repository.getProducts(
      query: _searchQuery,
      category: _selectedCategory,
    );

    _isLoading = false;
    notifyListeners();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    fetchProducts();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    fetchProducts();
  }
}

import 'package:flutter/material.dart';
import 'package:myson/data/repositories/i_product_repository.dart';
import 'package:myson/data/models/product.dart';

class CatalogViewModel extends ChangeNotifier {
  final IProductRepository _repository;

  CatalogViewModel(this._repository) {
    fetchProducts();
  }

  List<Product> _allProducts = [];
  List<Product> _products = [];
  List<Product> get products => _products;

  int _currentPage = 1;
  int get currentPage => _currentPage;
  final int _itemsPerPage = 6;

  int get totalPages => (_allProducts.length / _itemsPerPage).ceil();

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

    _allProducts = await _repository.getProducts(
      query: _searchQuery,
      category: _selectedCategory,
    );

    _updatePaginatedProducts();

    _isLoading = false;
    notifyListeners();
  }

  void _updatePaginatedProducts() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    _products = _allProducts.sublist(
      startIndex,
      endIndex > _allProducts.length ? _allProducts.length : endIndex,
    );
  }

  void setPage(int page) {
    if (page < 1 || page > totalPages) return;
    _currentPage = page;
    _updatePaginatedProducts();
    notifyListeners();
  }

  void updateCategory(String category) {
    _selectedCategory = category;
    _currentPage = 1;
    fetchProducts();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    fetchProducts();
  }
}

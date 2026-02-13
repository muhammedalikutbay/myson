import 'package:flutter/material.dart';

class CartService {
  // Singleton pattern for easy access
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // ValueNotifier allows widgets to listen to changes in cart count
  final ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  void addToCart() {
    cartCount.value++;
  }

  void clearCart() {
    cartCount.value = 0;
  }
}

import 'package:flutter/material.dart';
import 'package:myson/data/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>([]);
  final ValueNotifier<int> cartCount = ValueNotifier<int>(0);

  void addToCart(Product product) {
    final existingIndex = items.value.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex != -1) {
      items.value[existingIndex].quantity++;
    } else {
      items.value.add(CartItem(product: product));
    }

    _updateCart();
  }

  void removeFromCart(String productId) {
    items.value.removeWhere((item) => item.product.id == productId);
    _updateCart();
  }

  void updateQuantity(String productId, int delta) {
    final index = items.value.indexWhere(
      (item) => item.product.id == productId,
    );
    if (index != -1) {
      items.value[index].quantity += delta;
      if (items.value[index].quantity <= 0) {
        items.value.removeAt(index);
      }
      _updateCart();
    }
  }

  double get totalPrice {
    return items.value.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void _updateCart() {
    // Notify listeners manually since the list reference doesn't change
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    items.notifyListeners();
    cartCount.value = items.value.fold(0, (sum, item) => sum + item.quantity);
  }

  void clearCart() {
    items.value = [];
    cartCount.value = 0;
  }
}

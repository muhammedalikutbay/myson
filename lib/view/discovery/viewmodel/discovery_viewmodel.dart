import 'package:flutter/material.dart';

import 'package:myson/data/models/product.dart';

class DiscoveryViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Product? _dailyDeal;
  Product? get dailyDeal => _dailyDeal;

  List<Product> _featuredDeals = [];
  List<Product> get featuredDeals => _featuredDeals;

  DiscoveryViewModel() {
    _loadDeals();
  }

  void _loadDeals() {
    _isLoading = true;
    notifyListeners();

    // Mocking the daily deal from the image (Supersonic)
    _dailyDeal = Product(
      id: 'deal_1',
      name: 'Dyson Supersonic™',
      description: 'Günün Teklifi: %20 İndirim',
      price: 11000.0,
      originalPrice: 13750.0,
      badgeText: 'GÜNÜN TEKLİFİ',
      imageUrl: 'https://wantapi.com/assets/purifier.png', // Placeholder URL
      category: 'Hair Care',
    );

    // Mocking featured deals from the image
    _featuredDeals = [
      Product(
        id: 'deal_2',
        name: 'Dyson V15 Detect™',
        description: 'Güçlü emiş gücü ve lazer aydınlatma.',
        price: 15499.0,
        originalPrice: 18999.0,
        badgeText: 'SINIRLI SÜRE',
        imageUrl: 'https://wantapi.com/assets/purifier.png',
        category: 'Vacuum Cleaners',
      ),
      Product(
        id: 'deal_3',
        name: 'Dyson Airwrap™ Complete Long',
        description: 'Hacimli bukleler ve dalgalar.',
        price: 14850.0,
        originalPrice: 16500.0,
        badgeText: null,
        imageUrl: 'https://wantapi.com/assets/purifier.png',
        category: 'Hair Care',
      ),
      Product(
        id: 'deal_4',
        name: 'Dyson Purifier Cool™ Gen1',
        description: 'Havanızı otomatik olarak temizler ve serinletir.',
        price: 12100.0,
        originalPrice: 14200.0,
        badgeText: 'TÜKENİYOR',
        imageUrl: 'https://wantapi.com/assets/purifier.png',
        category: 'Air Quality',
      ),
      Product(
        id: 'deal_5',
        name: 'Dyson Gen5detect™ Complete',
        description: 'En güçlü kablosuz süpürgemiz.',
        price: 19200.0,
        originalPrice: 21500.0,
        badgeText: null,
        imageUrl: 'https://wantapi.com/assets/purifier.png',
        category: 'Vacuum Cleaners',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}

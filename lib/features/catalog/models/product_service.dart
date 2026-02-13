import 'package:myson/features/catalog/models/product.dart';

class ProductService {
  // Simulating a fetch from an API (JSON simulation)
  static List<Product> getMockProducts() {
    final List<Map<String, dynamic>> rawData = [
      {
        'id': 'v15-detect',
        'name': 'Dyson V15 Detect™',
        'description':
            'The most powerful, intelligent cordless vacuum. Reveals microscopic dust.',
        'price': 749.99,
        'imageUrl':
            'https://wantapi.com/assets/banner.png', // Using the suggested banner URL
        'category': 'Vacuum Cleaners',
      },
      {
        'id': 'supersonic',
        'name': 'Dyson Supersonic™',
        'description':
            'Fast drying. No extreme heat. Engineered for different hair types.',
        'price': 429.99,
        'imageUrl':
            'https://wantapi.com/assets/hair_dryer.png', // Placeholder-like naming
        'category': 'Hair Care',
      },
      {
        'id': 'purifier-cool',
        'name': 'Dyson Purifier Cool™',
        'description':
            'Automatically senses, captures and traps pollutants for cleaner air.',
        'price': 649.99,
        'imageUrl': 'https://wantapi.com/assets/purifier.png',
        'category': 'Air Quality',
      },
    ];

    return rawData.map((json) => Product.fromMap(json)).toList();
  }
}

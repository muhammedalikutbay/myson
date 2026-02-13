import 'package:myson/data/models/product.dart';

class ProductService {
  static final List<Map<String, dynamic>> _rawData = [
    {
      'id': 'v15-detect',
      'name': 'Dyson V15 Detect™',
      'description':
          'The most powerful, intelligent cordless vacuum. Reveals microscopic dust.',
      'price': 749.99,
      'imageUrl': 'https://wantapi.com/assets/banner.png',
      'category': 'Vacuums',
    },
    {
      'id': 'supersonic',
      'name': 'Dyson Supersonic™',
      'description':
          'Fast drying. No extreme heat. Engineered for different hair types.',
      'price': 429.99,
      'imageUrl': 'https://wantapi.com/assets/hair_dryer.png',
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

  static List<Product> getProducts({String? query, String? category}) {
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

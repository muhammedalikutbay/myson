import 'package:myson/data/models/product.dart';

class ProductService {
  static final List<Map<String, dynamic>> _rawData = _generateMockData();

  static List<Map<String, dynamic>> _generateMockData() {
    final List<Map<String, dynamic>> data = [];
    final categories = ['Vacuums', 'Hair Care', 'Air Quality'];
    final categoryDetails = {
      'Vacuums': {
        'name': 'Myson V',
        'price': 749.99,
        'img': 'https://wantapi.com/assets/banner.png',
      },
      'Hair Care': {
        'name': 'Myson Supersonic ',
        'price': 429.99,
        'img': 'https://wantapi.com/assets/hair_dryer.png',
      },
      'Air Quality': {
        'name': 'Myson Purifier ',
        'price': 649.99,
        'img': 'https://wantapi.com/assets/purifier.png',
      },
    };

    for (var cat in categories) {
      final details = categoryDetails[cat]!;
      for (var i = 1; i <= 12; i++) {
        data.add({
          'id': '${cat.toLowerCase().replaceAll(' ', '-')}-$i',
          'name': '${details['name']}$i™',
          'description':
              'Premium ${cat.toLowerCase()} technology by Myson. Model $i.',
          'price': (details['price'] as double) + (i * 10),
          'imageUrl': details['img'],
          'category': cat,
        });
      }
    }
    return data;
  }

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

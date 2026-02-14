class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String? badgeText;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.badgeText,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      originalPrice: (map['originalPrice'] != null)
          ? (map['originalPrice'] as num).toDouble()
          : null,
      badgeText: map['badgeText'],
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
    );
  }

  bool get isDiscounted => originalPrice != null && originalPrice! > price;
}

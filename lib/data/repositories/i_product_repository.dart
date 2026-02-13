import 'package:myson/data/models/product.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts({String? query, String? category});
  List<String> getCategories();
}

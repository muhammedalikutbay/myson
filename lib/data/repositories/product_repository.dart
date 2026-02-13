import 'package:myson/data/models/product.dart';
import 'package:myson/data/services/product_service.dart';
import 'package:myson/data/repositories/i_product_repository.dart';

class MockProductRepository implements IProductRepository {
  @override
  Future<List<Product>> getProducts({String? query, String? category}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ProductService.getProducts(query: query, category: category);
  }

  @override
  List<String> getCategories() {
    return ProductService.getCategories();
  }
}

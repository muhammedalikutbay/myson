import 'package:get_it/get_it.dart';
import 'package:myson/data/repositories/i_product_repository.dart';
import 'package:myson/data/repositories/product_repository.dart';
import 'package:myson/core/state/cart_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Repositories
  locator.registerLazySingleton<IProductRepository>(
    () => MockProductRepository(),
  );

  // Services / State
  locator.registerLazySingleton<CartService>(() => CartService());
}

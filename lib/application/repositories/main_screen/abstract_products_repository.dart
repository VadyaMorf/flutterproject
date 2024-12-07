import 'package:arch/application/model/product.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getAllProducts();
}
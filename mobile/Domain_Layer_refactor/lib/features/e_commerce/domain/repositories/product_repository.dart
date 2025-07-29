import 'package:domain_layer_refactor/features/e_commerce/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
}

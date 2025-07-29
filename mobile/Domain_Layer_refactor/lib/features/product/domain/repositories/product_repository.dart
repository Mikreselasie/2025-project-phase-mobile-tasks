import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(String id);
}

import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<void> createProduct({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
  });
  Future<void> deleteProduct(String id);
  Future<void> updateProduct(String id);
}

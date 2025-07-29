import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, Product>> createProduct({required Product product});
  Future<void> deleteProduct(String id);
  Future<void> updateProduct({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
    required String description,
  });
}

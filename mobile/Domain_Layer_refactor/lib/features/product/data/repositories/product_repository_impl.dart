import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/features/product/data/datasources/local_data_source.dart';
import 'package:domain_layer_refactor/features/product/data/models/product_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  late final LocalDataSource localDataSource;
  @override
  Future<void> deleteProduct(String id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await localDataSource
          .getCachedProducts(); // Should return List<Map<String, dynamic>>
      final products = result
          .map((json) => ProductModel.fromJSON(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(String id) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  late final LocalDataSource localDataSource;
  List<ProductModel> productList = [];
  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      final productIndex = productList.indexWhere(
        (product) => product.productId == id,
      );

      if (productIndex != -1) {
        productList.removeAt(productIndex);
        return const Right(unit);
      } else {
        return Left(NotFoundFailure());
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await localDataSource.getCachedProducts();
      final products = result
          .map((json) => ProductModel.fromJSON(json))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final products = await getAllProducts();
      return products.fold((failure) => Left(failure), (list) {
        final product = list.firstWhere((p) => p.productId == id);
        return Right(product);
      });
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    required Product product,
  }) async {
    try {
      final productJson = ProductModel.fromEntity(product).toJSON();
      await localDataSource.updateProduct(productJson);
      return Right(product);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct({
    required Product product,
  }) async {
    try {
      final productJson = ProductModel.fromEntity(product).toJSON();
      await localDataSource.saveProduct(productJson);
      return Right(product);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

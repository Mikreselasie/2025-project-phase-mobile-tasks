import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/features/product/data/datasources/local_data_source.dart';
import 'package:domain_layer_refactor/features/product/data/models/product_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  late final LocalDataSource localDataSource;
  List<ProductModel> productList = [];
  @override
  Future<void> deleteProduct(String id) async {
    final productIndex = productList.indexWhere(
      (product) => product.productId == id,
    );

    if (productIndex != -1) {
      productList.removeAt(productIndex); // Delete the product by index
    } else {
      throw Exception("Product not found!");
    }
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
  Future<Either<Failure, Product>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
    required String description,
  }) async {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

  @override
  Future<void> createProduct({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
  }) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }
}

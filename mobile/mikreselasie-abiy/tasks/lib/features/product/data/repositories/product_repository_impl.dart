import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/core/platform/network_info.dart';
import 'package:ecommerce/features/product/data/data_sources/remote_data_source.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  List<ProductModel> productList = [];

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final productIndex = productList.indexWhere(
          (product) => product.productId == id,
        );

        if (productIndex != -1) {
          productList.removeAt(productIndex);
          remoteDataSource.deleteProductFromServer(id);
          return const Right(unit);
        } else {
          return Left(NotFoundFailure("Not Found"));
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(products);
        return Right(products);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure("Unexpected error"));
      }
    } else {
      try {
        final products = await localDataSource.getAllCachedProducts();

        return Right(products);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        localDataSource.cacheProduct(product);
        return Right(product);
      } on ServerException catch (e) {
        return (Left(ServerFailure(e.message)));
      } catch (e) {
        return Left(CacheFailure("Cache Not Found Error"));
      }
    } else {
      try {
        final product = await localDataSource.getProductById(id);
        localDataSource.cacheProduct(product);
        return Right(product);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    required Product product,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final productJson = ProductModel.fromEntity(product);
        await remoteDataSource.updateProductOnServer(productJson);
        await localDataSource.cacheProduct(productJson);
        return Right(product);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct({
    required Product product,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final productJson = ProductModel.fromEntity(product).toJSON();
        await remoteDataSource.createProductOnServer(product as ProductModel);
        await localDataSource.saveProduct(productJson);
        return Right(product);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

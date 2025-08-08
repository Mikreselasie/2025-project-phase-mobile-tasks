import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/products_local_data_source.dart';
import '../data_sources/products_remote_data_source.dart';
import '../models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final LocalDataSource localDataSource;
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, T>> _handleRequest<T>({
    required Future<T> Function() onRemote,
    required Future<T> Function()? onLocal,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await onRemote();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else if (onLocal != null) {
      try {
        final result = await onLocal();
        return Right(result);
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() {
    return _handleRequest<List<Product>>(
      onRemote: () async {
        final products = await remoteDataSource.getAllProducts();
        await localDataSource.cacheProducts(products);
        return products;
      },
      onLocal: () => localDataSource.getAllCachedProducts(),
    );
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) {
    return _handleRequest<Product>(
      onRemote: () async {
        final product = await remoteDataSource.getProductById(id);
        await localDataSource.cacheProduct(product);
        return product;
      },
      onLocal: () => localDataSource.getProductById(id),
    );
  }

  @override
  Future<Either<Failure, Product>> createProduct({required Product product}) {
    return _handleRequest<Product>(
      onRemote: () async {
        final productModel = ProductModel.fromEntity(product);
        final created = await remoteDataSource.createProductOnServer(
          productModel,
        );
        await localDataSource.saveProduct(created.toJson());
        return created;
      },
      onLocal: null,
    );
  }

  @override
  Future<Either<Failure, Product>> updateProduct({required Product product}) {
    return _handleRequest<Product>(
      onRemote: () async {
        final model = ProductModel.fromEntity(product);
        final updated = await remoteDataSource.updateProductOnServer(model);
        await localDataSource.cacheProduct(updated);
        return updated;
      },
      onLocal: null,
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) {
    return _handleRequest<Unit>(
      onRemote: () async {
        await remoteDataSource.deleteProductFromServer(id);
        await localDataSource.deleteProduct(id);
        return unit;
      },
      onLocal: null,
    );
  }
}

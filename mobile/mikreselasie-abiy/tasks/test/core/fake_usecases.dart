import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeGetAllProducts extends GetAllProducts {
  FakeGetAllProducts() : super(FakeProductRepository());
}

class FakeProductRepository implements ProductRepository {
  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    return Right([]); // Return an empty list for testing
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    return Right(
      Product(
        id: "1234",
        name: 'Test Product',
        price: 10.0,
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
      ),
    );
  }

  @override
  Future<Either<Failure, Product>> createProduct({
    required Product product,
  }) async {
    return Right(product); // return product wrapped in Right for testing
  }

  @override
  @override
  Future<Either<Failure, Product>> updateProduct({
    required Product product,
  }) async {
    return Right(product); // Just echo back the product
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    return Right(unit);
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) {
    return getProduct(int.parse(id)); // Convert id to int
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) {
    return Future.value(
      Right([
        Product(
          id: "1234",
          name: 'Test Product',
          price: 10.0,
          description: 'Test Description',
          imageUrl: 'https://example.com/image.jpg',
        ),
      ]),
    );
  }
}

class FakeGetSingleProduct extends Fake implements GetProduct {
  // Future<void> call(int id) async {}
}

class FakeCreateProduct extends Fake implements CreateProduct {
  // Future<void> call(dynamic product) async {}
}

class FakeUpdateProduct extends Fake implements UpdateProduct {
  // Future<void> call(dynamic product) async {}
}

class FakeDeleteProduct extends Fake implements DeleteProduct {
  // Future<void> call(int id) async {}
}

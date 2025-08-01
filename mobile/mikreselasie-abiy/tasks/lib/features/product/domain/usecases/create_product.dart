import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'create_product_params.dart'; // or inline

class CreateProduct implements UseCase<void, CreateProductParams> {
  final ProductRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(CreateProductParams params) async {
    try {
      return await repository.createProduct(product: params.product);
      // Success — no return value
    } catch (e) {
      return Left(
        ServerFailure("Server Failure"),
      ); // or your defined Failure type
    }
  }
}

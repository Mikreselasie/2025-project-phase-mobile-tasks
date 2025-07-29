import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
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
      return Left(ServerFailure()); // or your defined Failure type
    }
  }
}

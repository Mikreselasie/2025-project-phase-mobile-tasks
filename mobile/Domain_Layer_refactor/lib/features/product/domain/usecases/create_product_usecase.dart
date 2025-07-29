import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'create_product_params.dart'; // or inline

class CreateProductUsecase implements UseCase<void, CreateProductParams> {
  final ProductRepository repository;

  CreateProductUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async {
    try {
      await repository.createProduct(
        id: params.id,
        name: params.name,
        price: params.price,
        imageUrl: params.imageUrl,
      );
      return const Right(null); // Success — no return value
    } catch (e) {
      return Left(ServerFailure()); // or your defined Failure type
    }
  }
}

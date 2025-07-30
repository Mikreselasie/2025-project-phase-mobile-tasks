import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/update_product_params.dart'; // if defined in a separate file

class UpdateProduct implements UseCase<void, UpdateProductParams> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(UpdateProductParams params) async {
    try {
      return await repository.updateProduct(product: params.product);
    } catch (e) {
      return Left(ServerFailure()); // or your own Failure subclass
    }
  }
}

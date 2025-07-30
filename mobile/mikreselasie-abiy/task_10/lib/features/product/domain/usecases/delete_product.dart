import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/delete_product_params.dart';

class DeleteProduct implements UseCase<void, DeleteProductParams> {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteProductParams params) async {
    try {
      // Call the repository to delete the product by its id.
      await repository.deleteProduct(params.productId);
      return const Right(unit); // Successfully deleted
    } catch (e) {
      return Left(ServerFailure()); // Handle failure (e.g., product not found)
    }
  }
}
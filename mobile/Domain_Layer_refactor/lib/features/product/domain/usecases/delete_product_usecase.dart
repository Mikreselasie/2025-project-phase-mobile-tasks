import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';

class DeleteProductUsecase implements UseCase<void, String> {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String productId) async {
    try {
      // Call the repository to delete the product by its id.
      await repository.deleteProduct(productId);
      return const Right(null); // Successfully deleted
    } catch (e) {
      return Left(ServerFailure()); // Handle failure (e.g., product not found)
    }
  }
}

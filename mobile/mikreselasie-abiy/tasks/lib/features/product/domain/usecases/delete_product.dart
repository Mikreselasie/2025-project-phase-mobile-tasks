import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product_params.dart';

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
      return Left(
        ServerFailure("Server Failure"),
      ); // Handle failure (e.g., product not found)
    }
  }
}

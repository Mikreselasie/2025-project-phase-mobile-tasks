import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart'; // if defined in a separate file

class UpdateProductUsecase implements UseCase<void, Product> {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(Product product) async {
    try {
      await repository.updateProduct(
        id: product.productId,
        name: product.name,
        price: product.price,
        imageUrl: product.imageURL,
        description: product.description,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure()); // or your own Failure subclass
    }
  }
}

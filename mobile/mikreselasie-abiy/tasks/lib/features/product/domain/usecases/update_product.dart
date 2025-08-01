import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product_params.dart'; // if defined in a separate file

class UpdateProduct implements UseCase<void, UpdateProductParams> {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<Either<Failure, Product>> call(UpdateProductParams params) async {
    try {
      return await repository.updateProduct(product: params.product);
    } catch (e) {
      return Left(
        ServerFailure("Sever Failure"),
      ); // or your own Failure subclass
    }
  }
}

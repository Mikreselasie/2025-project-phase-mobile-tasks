import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  ViewAllProductsUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getAllProducts();
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/errors/failures.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/product_params.dart';

class ViewProductUsecase implements UseCase<Product, ProductParams> {
  final ProductRepository repository;

  ViewProductUsecase({required this.repository});

  @override
  Future<Either<Failure, Product>> call(ProductParams params) async {
    final product = await repository.getProductById(params.id);
    return product;
  }
}

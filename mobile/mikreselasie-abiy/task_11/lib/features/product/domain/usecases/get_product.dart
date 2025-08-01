import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'get_product_params.dart';

class GetProduct implements UseCase<Product, GetProductParams> {
  final ProductRepository repository;

  GetProduct({required this.repository});

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) async {
    final product = await repository.getProductById(params.productId);
    return product;
  }
}

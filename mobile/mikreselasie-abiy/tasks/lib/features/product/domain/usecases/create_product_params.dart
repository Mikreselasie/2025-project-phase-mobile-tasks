import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class CreateProductParams extends Equatable {
  final Product product;

  const CreateProductParams({required this.product});

  @override
  List<Object?> get props => [product];
}

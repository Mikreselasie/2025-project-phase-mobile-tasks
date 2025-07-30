import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class UpdateProductParams extends Equatable {
  final Product product;

  UpdateProductParams({required this.product});

  @override
  List<Object?> get props => [product];
}

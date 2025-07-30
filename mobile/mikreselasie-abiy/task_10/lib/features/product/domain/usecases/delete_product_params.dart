import 'package:equatable/equatable.dart';

class DeleteProductParams extends Equatable {
  String productId;

  DeleteProductParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

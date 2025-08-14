import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DeleteProductParams extends Equatable {
  String productId;

  DeleteProductParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

import 'package:equatable/equatable.dart';

class GetProductParams extends Equatable {
  final productId;

  const GetProductParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

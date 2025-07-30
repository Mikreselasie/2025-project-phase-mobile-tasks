import 'package:equatable/equatable.dart';

class GetProductParams extends Equatable {
  final productId;

  GetProductParams({required this.productId});

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}

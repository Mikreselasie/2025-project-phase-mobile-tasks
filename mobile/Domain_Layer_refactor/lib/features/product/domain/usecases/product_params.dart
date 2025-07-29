import 'package:equatable/equatable.dart';

class ProductParams extends Equatable {
  final String id;

  ProductParams({required this.id});

  @override
  List<Object?> get props => [id];
}

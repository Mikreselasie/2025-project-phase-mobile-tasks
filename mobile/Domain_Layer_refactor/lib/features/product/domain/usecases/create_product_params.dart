import 'package:equatable/equatable.dart';

class CreateProductParams extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  const CreateProductParams({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, price, imageUrl, description];
}

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [name, description, price, imageUrl, id];
}

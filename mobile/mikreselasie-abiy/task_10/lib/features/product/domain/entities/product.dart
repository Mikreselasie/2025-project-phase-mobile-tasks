import 'package:equatable/equatable.dart';

class Product extends Equatable {
  String productId;
  String name;
  String description;
  String imageURL;
  double price;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.productId,
  });

  @override
  List<Object?> get props => [name, description, price, imageURL, productId];
}

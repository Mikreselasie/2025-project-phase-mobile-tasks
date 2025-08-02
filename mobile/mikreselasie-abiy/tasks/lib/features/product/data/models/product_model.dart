import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Product with EquatableMixin {
  const ProductModel({
    required super.name,
    required super.description,
    required super.price,
    required super.imageUrl,
    required super.id,
  });

  @override
  List<Object?> get props => [name, description, price, imageUrl, id];

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrl: json["imageUrl"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "imageUrl": imageUrl,
      "id": id,
    };
  }
}

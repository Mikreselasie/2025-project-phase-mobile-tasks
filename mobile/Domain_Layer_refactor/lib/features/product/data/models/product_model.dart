import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.description,
    required super.price,
    required super.imageURL,
    required super.id,
  });

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageURL: json["imageURL"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "imageURL": imageURL,
      "id": id,
    };
  }
}

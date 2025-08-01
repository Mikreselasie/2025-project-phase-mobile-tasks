import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.name,
    required super.description,
    required super.price,
    required super.imageURL,
    required super.productId,
  });

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      productId: product.productId,
      name: product.name,
      description: product.description,
      price: product.price,
      imageURL: product.imageURL,
    );
  }

  factory ProductModel.fromJSON(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageURL: json["imageURL"],
      productId: json["productId"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "imageURL": imageURL,
      "productId": productId,
    };
  }
}

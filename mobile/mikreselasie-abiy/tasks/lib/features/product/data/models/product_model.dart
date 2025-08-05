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
      price: (json['price'] is int)
          ? (json['price'] as int)
                .toDouble() // Convert int to double if necessary
          : json['price'] as double,
      imageUrl: json["imageUrl"],
      id: json["id"],
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
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

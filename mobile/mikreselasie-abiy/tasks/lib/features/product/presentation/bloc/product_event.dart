// product_event.dart

import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

// Base class for all product events
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

// Event to load all products
class LoadAllProductEvent extends ProductEvent {}

// Event to retrieve a single product by ID
class GetSingleProductEvent extends ProductEvent {
  final String productId;

  const GetSingleProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

// Event to update a product
class UpdateProductEvent extends ProductEvent {
  final Product updatedProduct;

  const UpdateProductEvent({required this.updatedProduct});

  @override
  List<Object?> get props => [updatedProduct];
}

// Event to delete a product by ID
class DeleteProductEvent extends ProductEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

// Event to create a new product
class CreateProductEvent extends ProductEvent {
  final Map<String, dynamic> productData;

  const CreateProductEvent(this.productData);

  @override
  List<Object?> get props => [productData];
}

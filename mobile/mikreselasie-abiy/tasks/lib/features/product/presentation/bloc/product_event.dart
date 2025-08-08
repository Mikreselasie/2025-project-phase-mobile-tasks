// product_event.dart

import 'package:ecommerce/features/product/data/models/product_model.dart';
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

class ProductImagePickedEvent extends ProductEvent {
  final String imagePath;

  const ProductImagePickedEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class ProductUpdated extends ProductEvent {
  final ProductModel product;

  const ProductUpdated(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductAdded extends ProductEvent {
  final ProductModel product;

  const ProductAdded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductsLoadRequested extends ProductEvent {
  const ProductsLoadRequested();

  @override
  List<Object?> get props => [];
}

class SearchProductEvent extends ProductEvent {
  final String query;

  SearchProductEvent(this.query);
}

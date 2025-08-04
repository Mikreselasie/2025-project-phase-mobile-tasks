import 'package:equatable/equatable.dart';

// You can replace dynamic with a proper Product model as needed
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// Represents the initial state of the app
class InitialState extends ProductState {}

// Indicates that data is being loaded
class LoadingState extends ProductState {}

// State when all products are loaded successfully
class LoadedAllProductState extends ProductState {
  final List<dynamic> products;

  const LoadedAllProductState(this.products);

  @override
  List<Object?> get props => [products];
}

// State when a single product is loaded successfully
class LoadedSingleProductState extends ProductState {
  final dynamic product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object?> get props => [product];
}

// Represents an error during any product operation
class ErrorState extends ProductState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

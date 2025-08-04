// product_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product_params.dart';
import 'package:equatable/equatable.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProduct getSingleProduct;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getSingleProduct,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(InitialState()) {
    on<LoadAllProductEvent>(_onLoadAllProduct);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProduct(
    LoadAllProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await getAllProducts(NoParams());

    result.fold(
      (failure) =>
          emit(ErrorState("Failed to load products: ${failure.message}")),
      (products) => emit(LoadedAllProductState(products)),
    );
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final product = await getSingleProduct(
      GetProductParams(productId: event.productId),
    );

    product.fold(
      (failure) =>
          emit(ErrorState("Failed to load product: ${failure.message}")),
      (product) => emit(LoadedSingleProductState(product)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final product = ProductModel.fromJson(event.productData); // or fromJson
    final result = await createProduct(CreateProductParams(product: product));

    result.fold(
      (failure) =>
          emit(ErrorState("Failed to create product: ${failure.message}")),
      (product) => add(
        LoadAllProductEvent(),
      ), // Only add LoadAllProductEvent if creation is successful
    );
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final result = await updateProduct(
      UpdateProductParams(product: event.updatedProduct),
    );
    result.fold(
      (failure) =>
          emit(ErrorState("Failed to update product: ${failure.message}")),
      (product) => add(
        LoadAllProductEvent(),
      ), // Only add LoadAllProductEvent if creation is successful
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await deleteProduct(
      DeleteProductParams(productId: event.productId),
    );
    result.fold(
      (failure) =>
          emit(ErrorState("Failed to delete product: ${failure.message}")),
      (product) => add(
        LoadAllProductEvent(),
      ), // Only add LoadAllProductEvent if creation is successful
    );
  }
}

class GetSingleProduct {}

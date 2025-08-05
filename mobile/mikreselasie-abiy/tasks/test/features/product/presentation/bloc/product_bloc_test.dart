import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce/features/product/domain/usecases/create_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce/features/product/domain/usecases/delete_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product_params.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product_params.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllProducts,
  CreateProduct,
  UpdateProduct,
  DeleteProduct,
  GetProduct,
])
void main() {
  late GetAllProducts getAllProducts;
  late CreateProduct createProduct;
  late UpdateProduct updateProduct;
  late DeleteProduct deleteProduct;
  late ProductBloc productBloc;
  late GetProduct getSingleProduct;

  setUp(() {
    getAllProducts = MockGetAllProducts();
    createProduct = MockCreateProduct();
    updateProduct = MockUpdateProduct();
    deleteProduct = MockDeleteProduct();
    getSingleProduct = MockGetProduct();
    productBloc = ProductBloc(
      getAllProducts: getAllProducts,
      getSingleProduct: getSingleProduct,
      createProduct: createProduct,
      updateProduct: updateProduct,
      deleteProduct: deleteProduct,
    );
  });

  const tProduct = ProductModel(
    id: 'id',
    name: 'name',
    description: 'description',
    price: 123.45,
    imageUrl: 'https://product.image.com/id',
  );
  const tProducts = [tProduct];

  test('initial state should be InitialState', () {
    expect(productBloc.state, InitialState());
  });

  group('loading products', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when products are loaded successfully',
      build: () => productBloc,
      setUp: () => when(
        getAllProducts(NoParams()),
      ).thenAnswer((_) async => const Right(tProducts)),
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [LoadingState(), LoadedAllProductState(tProducts)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when an error occurs while loading products',
      build: () => productBloc,
      setUp: () => when(
        getAllProducts(NoParams()),
      ).thenAnswer((_) async => const Left(ServerFailure('error'))),
      act: (bloc) => bloc.add(LoadAllProductEvent()),
      expect: () => [
        LoadingState(),
        ErrorState('Failed to load products: error'),
      ],
    );
  });

  group('creating a product', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when product is created successfully',
      build: () => productBloc,
      setUp: () {
        when(
          createProduct(CreateProductParams(product: tProduct)),
        ).thenAnswer((_) async => const Right(tProduct));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct.toJson())),
      expect: () => [LoadingState(), LoadedAllProductState(tProducts)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when an error occurs while creating a product',
      build: () => productBloc,
      setUp: () {
        when(
          createProduct(CreateProductParams(product: tProduct)),
        ).thenAnswer((_) async => const Left(ServerFailure('error')));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(CreateProductEvent(tProduct.toJson())),
      expect: () => [
        LoadingState(),
        ErrorState('Failed to create product: error'),
      ],
    );
  });

  group('updating a product', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when product is updated successfully',
      build: () => productBloc,
      setUp: () {
        when(
          updateProduct(UpdateProductParams(product: tProduct)),
        ).thenAnswer((_) async => const Right(tProduct));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(UpdateProductEvent(updatedProduct: tProduct)),
      expect: () => [LoadingState(), LoadedAllProductState(tProducts)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when an error occurs while updating a product',
      build: () => productBloc,
      setUp: () {
        when(
          updateProduct(UpdateProductParams(product: tProduct)),
        ).thenAnswer((_) async => const Left(ServerFailure('error')));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(UpdateProductEvent(updatedProduct: tProduct)),
      expect: () => [
        LoadingState(),
        ErrorState('Failed to update product: error'),
      ],
    );
  });

  group('deleting a product', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when product is deleted successfully',
      build: () => productBloc,
      setUp: () {
        when(
          deleteProduct(DeleteProductParams(productId: tProduct.id)),
        ).thenAnswer((_) async => const Right(unit));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tProduct.id)),
      expect: () => [LoadingState(), LoadedAllProductState(tProducts)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when an error occurs while deleting a product',
      build: () => productBloc,
      setUp: () {
        when(
          deleteProduct(DeleteProductParams(productId: tProduct.id)),
        ).thenAnswer((_) async => const Left(ServerFailure('error')));
        when(
          getAllProducts(NoParams()),
        ).thenAnswer((_) async => const Right(tProducts));
      },
      act: (bloc) => bloc.add(DeleteProductEvent(tProduct.id)),
      expect: () => [
        LoadingState(),
        ErrorState('Failed to delete product: error'),
      ],
    );
  });

  group('getting a single product', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when a single product is fetched successfully',
      build: () => productBloc,
      setUp: () {
        when(
          getSingleProduct(GetProductParams(productId: tProduct.id)),
        ).thenAnswer((_) async => const Right(tProduct));
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tProduct.id)),
      expect: () => [LoadingState(), LoadedSingleProductState(tProduct)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when an error occurs while fetching a single product',
      build: () => productBloc,
      setUp: () {
        when(
          getSingleProduct(GetProductParams(productId: tProduct.id)),
        ).thenAnswer((_) async => const Left(ServerFailure('error')));
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(tProduct.id)),
      expect: () => [
        LoadingState(),
        ErrorState('Failed to load product: error'),
      ],
    );
  });
}

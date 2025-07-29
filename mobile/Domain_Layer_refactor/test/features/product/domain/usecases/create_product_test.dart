import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/create_product.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/create_product_params.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late CreateProduct createProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    createProduct = CreateProduct(mockProductRepository);
  });

  test('should create product using the repository', () async {
    // arrange
    final tProduct = Product(
      productId: '',
      name: 'name',
      description: 'description',
      price: 123.45,
      imageURL: 'https://product.image.com/id',
    );

    when(
      mockProductRepository.createProduct(product: tProduct),
    ).thenAnswer((_) async => Right(tProduct));

    // act
    final result = await createProduct(CreateProductParams(product: tProduct));

    // assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.createProduct(product: tProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}

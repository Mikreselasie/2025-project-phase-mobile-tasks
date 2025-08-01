import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce/features/product/domain/usecases/get_product_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late GetProduct getProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProduct = GetProduct(repository: mockProductRepository);
  });

  test('should get product from the repository', () async {
    // arrange
    const tId = 'id';
    final tProduct = Product(
      productId: tId,
      name: 'name',
      description: 'description',
      price: 123.45,
      imageURL: 'https://product.image.com/id',
    );

    when(
      mockProductRepository.getProductById(tId),
    ).thenAnswer((_) async => Right(tProduct));

    // act
    final result = await getProduct(GetProductParams(productId: tId));

    // assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.getProductById(tId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}

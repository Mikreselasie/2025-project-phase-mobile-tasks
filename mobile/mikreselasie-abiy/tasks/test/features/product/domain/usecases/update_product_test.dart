import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/product/domain/entities/product.dart';
import 'package:ecommerce/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce/features/product/domain/usecases/update_product_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late UpdateProduct updateProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProduct = UpdateProduct(mockProductRepository);
  });

  test('should update product using the repository', () async {
    // arrange
    final tProduct = Product(
      id: '',
      name: 'name',
      description: 'description',
      price: 123.45,
      imageUrl: 'https://product.image.com/id',
    );

    when(
      mockProductRepository.updateProduct(product: tProduct),
    ).thenAnswer((_) async => Right(tProduct));

    // act
    final result = await updateProduct(UpdateProductParams(product: tProduct));

    // assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.updateProduct(product: tProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}

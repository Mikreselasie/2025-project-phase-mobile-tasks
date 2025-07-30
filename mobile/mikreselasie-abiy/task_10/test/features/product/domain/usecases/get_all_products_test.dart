import 'package:dartz/dartz.dart';
import 'package:domain_layer_refactor/core/usecases/usecase.dart';
import 'package:domain_layer_refactor/features/product/domain/entities/product.dart';
import 'package:domain_layer_refactor/features/product/domain/repositories/product_repository.dart';
import 'package:domain_layer_refactor/features/product/domain/usecases/get_all_products.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Run the following command to generate needed files:
// dart run build_runner build
import 'get_all_products_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late GetAllProducts getAllProducts;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProducts = GetAllProducts(mockProductRepository);
  });

  test('should get all products from the repository', () async {
    // arrange
    final tProduct = <Product>[];

    when(
      mockProductRepository.getAllProducts(),
    ).thenAnswer((_) async => Right(tProduct));

    // act
    final result = await getAllProducts(NoParams());

    // assert
    expect(result, Right(tProduct));
    verify(mockProductRepository.getAllProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}

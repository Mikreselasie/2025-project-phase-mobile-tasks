import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/data_sources/products_local_data_source_impl.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/fixtures/fixiture_reader.dart';
import 'product_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataSourceImpl productLocalDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSource = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const tProductId1 = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  const tProductId2 = 'cccccc-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  const tProduct1 = ProductModel(
    id: tProductId1,
    name: 'HP Victus 15',
    description: 'Personal computer',
    price: 123.45,
    imageUrl:
        'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
  );
  const tProduct2 = ProductModel(
    id: tProductId2,
    name: 'Lenovo Legion 5',
    description: 'Personal computer',
    price: 123.45,
    imageUrl:
        'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
  );

  const tProducts = [tProduct1, tProduct2];

  final tProductsFixture = fixiture('products.json');
  final tProduct1Fixture = jsonEncode(jsonDecode(fixiture('products.json')));

  group('cacheProduct', () {
    test('should call setString of shared preferences', () async {
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      await productLocalDataSource.cacheProduct(tProduct1);

      verify(mockSharedPreferences.setString(any, any));
    });
  });

  group('cacheProducts', () {
    test('should call setString of shared preferences', () async {
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      await productLocalDataSource.cacheProducts(tProducts);

      verify(mockSharedPreferences.setString(any, any));
    });
  });

  group('getProduct', () {
    test('should return ProductModel from shared preferences', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(tProduct1Fixture);

      final result = await productLocalDataSource.getProductById(tProductId1);

      expect(result, tProduct1);
    });

    test('should throw CacheException when product not found', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = productLocalDataSource.getProductById;

      expect(
        () => call(tProductId1),
        throwsA(const TypeMatcher<CacheException>()),
      );
    });
  });

  group('getProducts', () {
    test('should return List<ProductModel> from shared preferences', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(tProductsFixture);

      final result = await productLocalDataSource.getAllCachedProducts();

      expect(result, tProducts);
    });

    test('should throw CacheException when products not found', () async {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = productLocalDataSource.getAllCachedProducts;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('deleteProduct', () {
    test(
      'should call setString to update the product list after deletion',
      () async {
        // arrange: Mock the getString to return a list of products
        final productList = [
          ProductModel(
            id: 'product1',
            name: 'Product 1',
            description: 'Description 1',
            price: 100,
            imageUrl: 'http://example.com/product1.png',
          ),
          ProductModel(
            id: 'product2',
            name: 'Product 2',
            description: 'Description 2',
            price: 200,
            imageUrl: 'http://example.com/product2.png',
          ),
        ];

        final productListJson = json.encode(
          productList.map((e) => e.toJson()).toList(),
        );

        when(
          mockSharedPreferences.getString(CACHED_PRODUCTS),
        ).thenReturn(productListJson);
        when(
          mockSharedPreferences.setString(any, any),
        ).thenAnswer((_) async => true);

        // act: Call the method under test
        await productLocalDataSource.deleteProduct('product1');

        // assert: Verify that setString was called with the updated product list
        final updatedListJson = json.encode(
          productList
              .where(
                (product) => product.id != 'product1',
              ) // Product 1 should be removed
              .map((e) => e.toJson())
              .toList(),
        );

        verify(
          mockSharedPreferences.setString(CACHED_PRODUCTS, updatedListJson),
        );
      },
    );
  });

  group('local storage', () {
    late SharedPreferences sharedPreferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPreferences = await SharedPreferences.getInstance();
      productLocalDataSource = LocalDataSourceImpl(
        sharedPreferences: sharedPreferences,
      );
    });

    test(
      'should return product when getProduct is called after cacheProduct',
      () async {
        await productLocalDataSource.cacheProduct(tProduct1);

        final result = await productLocalDataSource.getProductById(
          tProduct1.id,
        );

        expect(result, tProduct1);
      },
    );

    test(
      'should return list of products when getProducts is called after cacheProducts',
      () async {
        await productLocalDataSource.cacheProducts(tProducts);

        final result = await productLocalDataSource.getAllCachedProducts();

        expect(result, tProducts);
      },
    );
  });

  group('delete', () {
    late SharedPreferences sharedPreferences;

    const internalProductCacheKey = 'PRODUCTS_$tProductId1';

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        internalProductCacheKey: tProduct1Fixture,
      });
      sharedPreferences = await SharedPreferences.getInstance();
      productLocalDataSource = LocalDataSourceImpl(
        sharedPreferences: sharedPreferences,
      );
    });

    test('should remove product from shared preferences', () async {
      expect(sharedPreferences.containsKey(internalProductCacheKey), true);

      await productLocalDataSource.deleteProduct(tProduct1.id);

      expect(sharedPreferences.containsKey(internalProductCacheKey), false);
    });
  });
}

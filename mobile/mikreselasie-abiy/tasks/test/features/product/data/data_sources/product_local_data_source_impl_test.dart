import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/data_sources/products_local_data_source_impl.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'product_local_data_source_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataSourceImpl dataSource;

  const cachedProductsKey = 'CACHED_PRODUCTS';

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
  final tProducts = [tProduct1, tProduct2];

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cacheProduct', () {
    test(
      'should append product to cached list and save via setString',
      () async {
        // arrange
        when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(
          jsonEncode([]),
        ); // or jsonEncode([]) if your code handles empty cache this way

        when(
          mockSharedPreferences.setString(any, any),
        ).thenAnswer((_) async => true);

        // act
        await dataSource.cacheProduct(tProduct1);

        // assert
        final expectedJson = jsonEncode([tProduct1.toJson()]);
        verify(
          mockSharedPreferences.setString(cachedProductsKey, expectedJson),
        );
      },
    );
  });

  group('cacheProducts', () {
    test('should call setString once with all products', () async {
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      await dataSource.cacheProducts(tProducts);

      final expectedJson = jsonEncode(
        tProducts.map((e) => e.toJson()).toList(),
      );
      verify(
        mockSharedPreferences.setString(cachedProductsKey, expectedJson),
      ).called(1);
    });
  });

  group('getProductById', () {
    test('should return the correct ProductModel from cached list', () async {
      final jsonList = jsonEncode(tProducts.map((e) => e.toJson()).toList());

      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonList);

      final result = await dataSource.getProductById(tProduct1.id);

      expect(result, equals(tProduct1));
    });

    test('should throw CacheException when no products in cache', () {
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      expect(
        () => dataSource.getProductById(tProduct1.id),
        throwsA(isA<CacheException>()),
      );
    });

    test('should throw CacheException when product ID not found', () {
      final jsonList = jsonEncode([
        tProduct2.toJson(),
      ]); // not including tProduct1
      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonList);

      expect(
        () => dataSource.getProductById(tProduct1.id),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('getAllCachedProducts', () {
    test('should return list of ProductModels from cache', () async {
      final jsonList = jsonEncode(tProducts.map((e) => e.toJson()).toList());
      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonList);

      final result = await dataSource.getAllCachedProducts();

      expect(result, equals(tProducts));
    });

    test('should throw CacheException when no products cached', () {
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      expect(
        () => dataSource.getAllCachedProducts(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('deleteProduct', () {
    test('should remove product by ID and update cache', () async {
      final productsBefore = [tProduct1, tProduct2];
      final productsAfter = [tProduct2];

      final jsonBefore = jsonEncode(
        productsBefore.map((e) => e.toJson()).toList(),
      );
      final jsonAfter = jsonEncode(
        productsAfter.map((e) => e.toJson()).toList(),
      );

      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonBefore);
      when(
        mockSharedPreferences.setString(cachedProductsKey, jsonAfter),
      ).thenAnswer((_) async => true);

      await dataSource.deleteProduct(tProduct1.id);

      verify(
        mockSharedPreferences.setString(cachedProductsKey, jsonAfter),
      ).called(1);
    });

    test('should throw CacheException if no cache exists', () {
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      expect(
        () => dataSource.deleteProduct(tProduct1.id),
        throwsA(isA<CacheException>()),
      );
    });

    test('should throw CacheException if product ID not found', () {
      final jsonList = jsonEncode([tProduct2.toJson()]); // tProduct1 missing
      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonList);

      expect(
        () => dataSource.deleteProduct(tProduct1.id),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('updateProduct', () {
    test('should update a product in the cached list', () async {
      final updatedProduct = tProduct1.copyWith(name: 'Updated Name');
      final initialList = [tProduct1, tProduct2];
      final updatedList = [updatedProduct, tProduct2];

      final jsonBefore = jsonEncode(
        initialList.map((e) => e.toJson()).toList(),
      );
      final jsonAfter = jsonEncode(updatedList.map((e) => e.toJson()).toList());

      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonBefore);
      when(
        mockSharedPreferences.setString(cachedProductsKey, jsonAfter),
      ).thenAnswer((_) async => true);

      await dataSource.updateProduct(updatedProduct);

      verify(
        mockSharedPreferences.setString(cachedProductsKey, jsonAfter),
      ).called(1);
    });

    test('should throw CacheException when no cache exists', () {
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      expect(
        () => dataSource.updateProduct(tProduct1),
        throwsA(isA<CacheException>()),
      );
    });

    test('should throw CacheException if product to update is not found', () {
      final jsonList = jsonEncode([tProduct2.toJson()]);
      when(
        mockSharedPreferences.getString(cachedProductsKey),
      ).thenReturn(jsonList);

      expect(
        () => dataSource.updateProduct(tProduct1),
        throwsA(isA<CacheException>()),
      );
    });
  });
}

import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/product/data/data_sources/products_local_data_source.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/fixtures/fixiture_reader.dart';
import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late LocalDataSourceImpl localDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = LocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const tProductId1 = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  const tProductId2 = 'cccccc-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
  final tProduct1 = ProductModel(
    productId: tProductId1,
    name: 'HP Victus 15',
    description: 'Personal computer',
    price: 123.45,
    imageURL:
        'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
  );
  final tProduct2 = ProductModel(
    productId: tProductId2,
    name: 'Lenovo Legion 5',
    description: 'Personal computer',
    price: 123.45,
    imageURL:
        'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
  );

  final tProducts = [tProduct1, tProduct2];
  final tProductsFixture = fixiture('products.json');
  final tProduct1Fixture = jsonEncode(jsonDecode(fixiture('product.json')));

  group("getAllCachedProducts", () {
    test(
      "Should return ProductModel when there're some in the cache",
      () async {
        // arrange
        when(
          mockSharedPreferences.getString(any),
        ).thenReturn(fixiture("products.json"));
        // act
        final result = await localDataSourceImpl.getAllCachedProducts();
        // assert
        verify(mockSharedPreferences.getString(CACHED_PRODUCTS));
        expect(result, equals(tProducts));
      },
    );
    test(
      "Should throw  CacheEcception when there's nothing in the cache",
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = await localDataSourceImpl.getAllCachedProducts;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('getProductById', () {
    const productId = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';

    final tProduct = ProductModel(
      productId: productId,
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageURL:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
    );

    test('should return ProductModel from cache when ID matches', () async {
      // arrange
      final productsJson = fixiture('products.json'); // Must include tProduct
      when(
        mockSharedPreferences.getString("CACHED_PRODUCTS"),
      ).thenReturn(productsJson);

      // act
      final result = await localDataSourceImpl.getProductById(productId);

      // assert
      verify(mockSharedPreferences.getString("CACHED_PRODUCTS"));
      expect(result, equals(tProduct));
    });

    test('should throw CacheException when product ID not found', () {
      // arrange
      final productsJson = fixiture(
        'products.json',
      ); // Should NOT contain the given ID
      when(
        mockSharedPreferences.getString("CACHED_PRODUCTS"),
      ).thenReturn(productsJson);

      // act
      final call = localDataSourceImpl.getProductById;

      // assert
      expect(
        () => call("non_existing_id"),
        throwsA(const TypeMatcher<CacheException>()),
      );
    });

    test('should throw CacheException when there is no cached data', () {
      // arrange
      when(mockSharedPreferences.getString("CACHED_PRODUCTS")).thenReturn(null);

      // act
      final call = localDataSourceImpl.getProductById;

      // assert
      expect(
        () => call(productId),
        throwsA(const TypeMatcher<CacheException>()),
      );
    });
  });

  group('cacheProducts', () {
    const productId = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';

    final tProduct = ProductModel(
      productId: productId,
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageURL:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
    );

    test('should call SharedPreferences to save data', () async {
      // arrange
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);
      // act

      // assert
      final jsonList = json.decode(fixiture("products.json")) as List;
      final tProducts = jsonList.map((e) => ProductModel.fromJSON(e)).toList();
      final expectedJson = json.encode(
        tProducts.map((e) => e.toJSON()).toList(),
      );

      await localDataSourceImpl.cacheProducts(tProducts);

      verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson));
    });
  });

  group('cacheProduct', () {
    const productId = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';
    final tProduct = ProductModel(
      productId: productId,
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageURL:
          'https://www.omen.com/content/dam/sites/omen/worldwide/laptops/2022-victus-15-intel/Hero%20Image%203.png',
    );

    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      final expectedJsonString = json.encode(tProduct.toJSON());

      // act
      await localDataSourceImpl.cacheProduct(tProduct);

      // assert
      verify(
        mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJsonString),
      );
    });
  });

  test('should delete product with matching ID and update cache', () async {
    // arrange
    const productIdToDelete = 'acadea83-1b1b-4b1b-8b1b-1b1b1b1b1b1b';

    final product1 = ProductModel(
      productId: productIdToDelete,
      name: 'HP Victus 15',
      description: 'Personal computer',
      price: 123.45,
      imageURL: 'https://example.com/1.png',
    );

    final product2 = ProductModel(
      productId: 'other-id',
      name: 'Another Laptop',
      description: 'Another one',
      price: 456.78,
      imageURL: 'https://example.com/2.png',
    );

    final initialList = [product1, product2];
    final cachedJson = json.encode(initialList.map((e) => e.toJSON()).toList());

    when(
      mockSharedPreferences.getString(CACHED_PRODUCTS),
    ).thenReturn(cachedJson);

    when(
      mockSharedPreferences.setString(any, any),
    ).thenAnswer((_) async => true);

    final expectedJson = json.encode([product2.toJSON()]);

    // act
    await localDataSourceImpl.deleteProduct(productIdToDelete);

    // assert
    verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson));
  });

  test('should add product to existing cache and save it', () async {
    // arrange
    final existingProductJson = {
      'productId': '123',
      'name': 'Laptop A',
      'description': 'Nice laptop',
      'price': 1000.0,
      'imageURL': 'https://example.com/a.png',
    };

    final newProductJson = {
      'productId': '456',
      'name': 'Laptop B',
      'description': 'New model',
      'price': 1500.0,
      'imageURL': 'https://example.com/b.png',
    };

    final initialCache = json.encode([existingProductJson]);
    final expectedCache = json.encode([existingProductJson, newProductJson]);

    when(
      mockSharedPreferences.getString(CACHED_PRODUCTS),
    ).thenReturn(initialCache);

    when(
      mockSharedPreferences.setString(any, any),
    ).thenAnswer((_) async => true);

    // act
    await localDataSourceImpl.saveProduct(newProductJson);

    // assert
    verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedCache));
  });

  test(
    'should update existing product and save to SharedPreferences',
    () async {
      // arrange
      const productId = 'abc123';

      final oldProduct = ProductModel(
        productId: productId,
        name: 'Old Laptop',
        description: 'Old description',
        price: 1000.0,
        imageURL: 'https://example.com/old.png',
      );

      final updatedProduct = ProductModel(
        productId: productId,
        name: 'New Laptop',
        description: 'Updated description',
        price: 1100.0,
        imageURL: 'https://example.com/new.png',
      );

      final initialList = [oldProduct];
      final updatedList = [updatedProduct];

      final cachedJson = json.encode(
        initialList.map((e) => e.toJSON()).toList(),
      );
      final expectedJson = json.encode(
        updatedList.map((e) => e.toJSON()).toList(),
      );

      when(
        mockSharedPreferences.getString(CACHED_PRODUCTS),
      ).thenReturn(cachedJson);

      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);

      // act
      await localDataSourceImpl.updateProduct(updatedProduct);

      // assert
      verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson));
    },
  );
}

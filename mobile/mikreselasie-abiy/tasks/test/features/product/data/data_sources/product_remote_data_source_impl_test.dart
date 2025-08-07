import 'dart:convert';

import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/core/network/http.dart';
import 'package:ecommerce/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/fixtures/fixiture_reader.dart';
import 'product_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HttpClient, http.MultipartRequest])
void main() {
  late MockHttpClient mockHttpClient;

  late ProductRemoteDataSourceImpl productRemoteDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSource = ProductRemoteDataSourceImpl(
      client: mockHttpClient,
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

  final tProductsFixture = jsonEncode({
    'data': jsonDecode(fixiture('product_list.json')),
  });
  final tProduct1Fixture = jsonEncode({
    'data': jsonDecode(fixiture('product.json')),
  });

  group('getProducts', () {
    test(
      'should return list of products when the response code is 200',
      () async {
        when(mockHttpClient.get(('$baseUrl/products'))).thenAnswer(
          (_) async => HttpResponse(body: tProductsFixture, statusCode: 200),
        );

        final result = await productRemoteDataSource.getAllProducts();

        expect(result, tProducts);
      },
    );

    test(
      'should throw ServerException when the response code is not 200',
      () async {
        when(mockHttpClient.get(('$baseUrl/products'))).thenAnswer(
          (_) async => const HttpResponse(body: 'Not Found', statusCode: 404),
        );

        final call = productRemoteDataSource.getAllProducts;

        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getProduct', () {
    test('should return product when the response code is 200', () async {
      when(mockHttpClient.get(('$baseUrl/products/$tProductId1'))).thenAnswer(
        (_) async => HttpResponse(body: tProduct1Fixture, statusCode: 200),
      );

      final result = await productRemoteDataSource.getProductById(tProductId1);

      expect(result, tProduct1);
    });

    test(
      'should throw ServerException when the response code is not 200',
      () async {
        when(mockHttpClient.get(('$baseUrl/products/$tProductId1'))).thenAnswer(
          (_) async => const HttpResponse(body: 'Not Found', statusCode: 404),
        );

        final call = productRemoteDataSource.getProductById;

        expect(() => call(tProductId1), throwsA(isA<ServerException>()));
      },
    );
  });

  group('createProduct', () {
    test('should return product when the response code is 201', () async {
      when(
        mockHttpClient.uploadFile(
          '$baseUrl/products',
          HttpMethod.post,
          any,
          any,
        ),
      ).thenAnswer(
        (_) async => HttpResponse(body: tProduct1Fixture, statusCode: 201),
      );

      final result = await productRemoteDataSource.createProductOnServer(
        tProduct1,
      );

      expect(result, tProduct1);
    });

    test(
      'should throw ServerException when the response code is not 201',
      () async {
        when(
          mockHttpClient.uploadFile(('$baseUrl/products'), any, any, any),
        ).thenAnswer(
          (_) async => const HttpResponse(body: 'Not Found', statusCode: 404),
        );

        final call = productRemoteDataSource.createProductOnServer;

        expect(() => call(tProduct1), throwsA(isA<ServerException>()));
      },
    );
  });

  group('updateProduct', () {
    test('should return product when the response code is 200', () async {
      when(
        mockHttpClient.put(
          ('$baseUrl/products/$tProductId1'),
          tProduct1.toJson(),
        ),
      ).thenAnswer(
        (_) async => HttpResponse(body: tProduct1Fixture, statusCode: 200),
      );

      final result = await productRemoteDataSource.updateProductOnServer(
        tProduct1,
      );

      expect(result, tProduct1);
    });

    test(
      'should throw ServerException when the response code is not 200',
      () async {
        when(
          mockHttpClient.put(
            ('$baseUrl/products/$tProductId1'),
            tProduct1.toJson(),
          ),
        ).thenAnswer(
          (_) async => const HttpResponse(body: 'Not Found', statusCode: 404),
        );

        final call = productRemoteDataSource.updateProductOnServer;

        expect(() => call(tProduct1), throwsA(isA<ServerException>()));
      },
    );
  });

  group('deleteProduct', () {
    test('should make delete request', () async {
      when(
        mockHttpClient.delete(('$baseUrl/products/$tProductId1')),
      ).thenAnswer(
        (_) async => HttpResponse(body: tProduct1Fixture, statusCode: 200),
      );

      await productRemoteDataSource.deleteProductFromServer(tProductId1);

      verify(
        mockHttpClient.delete(('$baseUrl/products/$tProductId1')),
      ).called(1);
    });

    test(
      'should throw ServerException when the response code is not 200',
      () async {
        when(
          mockHttpClient.delete(('$baseUrl/products/$tProductId1')),
        ).thenAnswer(
          (_) async => const HttpResponse(body: 'Not Found', statusCode: 404),
        );

        final call = productRemoteDataSource.deleteProductFromServer;

        expect(() => call(tProductId1), throwsA(isA<ServerException>()));
      },
    );
  });
}

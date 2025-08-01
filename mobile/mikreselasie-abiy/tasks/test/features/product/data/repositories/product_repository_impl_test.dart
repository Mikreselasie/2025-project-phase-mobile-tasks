import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/platform/network_info.dart';
import 'package:ecommerce/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce/features/product/data/models/product_model.dart';
import 'package:ecommerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RemoteDataSource>(as: #MockProductRemoteDataSource),
  MockSpec<LocalDataSource>(as: #MockProductLocalDataSource),
  MockSpec<NetworkInfo>(as: #MockNetworkInfo),
])
void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl productRepository;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepository = ProductRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockProductRemoteDataSource,
      localDataSource: mockProductLocalDataSource,
    );
  });

  const tProductId = 'id';
  final tProduct = ProductModel(
    productId: tProductId,
    name: 'name',
    description: 'description',
    price: 123.45,
    imageURL: 'https://product.image.com/id',
  );
  final tProducts = [tProduct];
  final tProductsAsMap = [
    {
      "productId": "id",
      "name": 'name',
      "description": "description",
      "price": 123.45,
      "imageURL": "https://product.image.com/id",
    },
  ];

  group('when network is available', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    group('getAllProducts', () {
      test('should get products from remote data source', () async {
        when(
          mockProductRemoteDataSource.getAllProducts(),
        ).thenAnswer((_) async => tProducts);

        final result = await productRepository.getAllProducts();

        expect(result.fold((l) => l, (r) => r), tProducts);
        verify(mockProductRemoteDataSource.getAllProducts());
      });

      test('should cache products from remote data source', () async {
        when(
          mockProductRemoteDataSource.getAllProducts(),
        ).thenAnswer((_) async => tProducts);

        await productRepository.getAllProducts();

        verify(mockProductRemoteDataSource.getAllProducts());
        verify(mockProductLocalDataSource.cacheProducts(tProducts));
      });

      test(
        'should return server failure when remote data source throws server exception',
        () async {
          when(
            mockProductRemoteDataSource.getAllProducts(),
          ).thenThrow(const ServerException(message: 'Server Exception'));

          final result = await productRepository.getAllProducts();

          expect(result, Left(ServerFailure('Server Exception')));
        },
      );
    });

    group('getProductById', () {
      test('should get product from remote data source', () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(
          mockProductRemoteDataSource.getProductById(tProductId),
        ).thenAnswer((_) async => tProduct);

        final result = await productRepository.getProductById(tProductId);

        expect(result.fold((l) => l, (r) => r), tProduct);
        verify(mockProductRemoteDataSource.getProductById(tProductId));
      });

      test('should cache product from remote data source', () async {
        when(
          mockProductRemoteDataSource.getProductById(tProductId),
        ).thenAnswer((_) async => tProduct);

        await productRepository.getProductById(tProductId);

        verify(mockProductRemoteDataSource.getProductById(tProductId));
        verify(mockProductLocalDataSource.cacheProduct(tProduct));
      });

      test(
        'should return server failure when remote data source throws server exception',
        () async {
          when(
            mockProductRemoteDataSource.getProductById(tProductId),
          ).thenThrow(const ServerException(message: 'Server Exception'));

          final result = await productRepository.getProductById(tProductId);

          expect(result, const Left(ServerFailure('Server Exception')));
        },
      );
    });

    group('createProduct', () {
      test('should create product from remote data source', () async {
        when(
          mockProductRemoteDataSource.createProductOnServer(tProduct),
        ).thenAnswer((_) async => tProductsAsMap[0]);

        final result = await productRepository.createProduct(product: tProduct);

        expect(result, Right(tProduct));
        verify(mockProductRemoteDataSource.createProductOnServer(tProduct));
      });

      test(
        'should return server failure when remote data source throws server exception',
        () async {
          when(
            mockProductRemoteDataSource.createProductOnServer(tProduct),
          ).thenThrow(const ServerException(message: 'Server Exception'));

          final result = await productRepository.createProduct(
            product: tProduct,
          );

          expect(result, const Left(ServerFailure('Server Exception')));
        },
      );
    });

    group('deleteProduct', () {
      test('should delete product from remote data source', () async {
        productRepository.productList.add(tProduct);

        await productRepository.deleteProduct(tProductId);

        verify(mockProductRemoteDataSource.deleteProductFromServer(tProductId));
      });

      test(
        'should return server failure when remote data source throws server exception',
        () async {
          // ✅ Add the product into memory so the delete logic proceeds
          productRepository.productList.add(tProduct);

          // ✅ Mock the remote call to throw the exception
          when(
            mockProductRemoteDataSource.deleteProductFromServer(tProductId),
          ).thenThrow(const ServerException(message: 'Server Exception'));

          final result = await productRepository.deleteProduct(tProductId);

          expect(result, const Left(ServerFailure('Server Exception')));
        },
      );
    });

    group('updateProduct', () {
      test('should update product from remote data source', () async {
        when(
          mockProductRemoteDataSource.updateProductOnServer(tProduct),
        ).thenAnswer((_) async => tProduct);

        final result = await productRepository.updateProduct(product: tProduct);

        expect(result, Right(tProduct));

        verify(mockProductRemoteDataSource.updateProductOnServer(tProduct));
      });

      test('should update cache product from remote data source', () async {
        when(
          mockProductRemoteDataSource.updateProductOnServer(any),
        ).thenAnswer((_) async => tProduct);
        when(
          mockProductLocalDataSource.cacheProduct(any),
        ).thenAnswer((_) async => Future.value());

        await productRepository.updateProduct(product: tProduct);

        verify(mockProductRemoteDataSource.updateProductOnServer(tProduct));
        verify(mockProductLocalDataSource.cacheProduct(tProduct));
      });

      test(
        'should return server failure when remote data source throws server exception',
        () async {
          when(
            mockProductRemoteDataSource.updateProductOnServer(tProduct),
          ).thenThrow(const ServerException(message: 'Server Exception'));

          final result = await productRepository.updateProduct(
            product: tProduct,
          );

          expect(result, const Left(ServerFailure('Server Exception')));
        },
      );
    });
  });

  group('when network is not available', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    group('getProducts', () {
      test('should get products from local data source', () async {
        when(
          mockProductLocalDataSource.getAllCachedProducts(),
        ).thenAnswer((_) async => tProducts);

        final result = await productRepository.getAllProducts();

        expect(result, Right(tProducts));
        verify(mockProductLocalDataSource.getAllCachedProducts());
      });

      test('should not call remote data source', () async {
        await productRepository.getAllProducts();

        verifyZeroInteractions(mockProductRemoteDataSource);
      });

      test(
        'should return cache failure when local data source throws cache exception',
        () async {
          when(
            mockProductLocalDataSource.getAllCachedProducts(),
          ).thenThrow(const CacheException(message: 'Cache Exception'));

          final result = await productRepository.getAllProducts();

          expect(result, const Left(CacheFailure('Cache Exception')));
        },
      );
    });

    group('getProduct', () {
      test('should get product from local data source', () async {
        when(
          mockProductLocalDataSource.getProductById(tProductId),
        ).thenAnswer((_) async => tProduct);

        final result = await productRepository.getProductById(tProductId);

        expect(result, Right(tProduct));
        verify(mockProductLocalDataSource.getProductById(tProductId));
      });

      test('should not call remote data source', () async {
        await productRepository.getProductById(tProductId);

        verifyZeroInteractions(mockProductRemoteDataSource);
      });

      test(
        'should return cache failure when local data source throws cache exception',
        () async {
          when(
            mockProductLocalDataSource.getProductById(tProductId),
          ).thenThrow(const CacheException(message: 'Cache Exception'));

          final result = await productRepository.getProductById(tProductId);

          expect(result, const Left(CacheFailure('Cache Exception')));
        },
      );
    });

    group('createProduct', () {
      test('should return network failure', () async {
        final result = await productRepository.createProduct(product: tProduct);

        expect(result, const Left(NetworkFailure()));
      });
    });

    group('deleteProduct', () {
      test('should return network failure', () async {
        final result = await productRepository.deleteProduct(tProductId);

        expect(result, const Left(NetworkFailure()));
      });
    });

    group('updateProduct', () {
      test('should return network failure', () async {
        final result = await productRepository.updateProduct(product: tProduct);

        expect(result, const Left(NetworkFailure()));
      });
    });
  });
}

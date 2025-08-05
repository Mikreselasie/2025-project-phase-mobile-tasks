// test/core/network/network_info_test.dart

import 'package:ecommerce/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnection])
void main() {
  late MockInternetConnection mockInternetConnection;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(connetctionChecker: mockInternetConnection);
  });

  group('isConnected', () {
    test('should return true when InternetConnection has access', () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);

      when(
        mockInternetConnection.hasInternetAccess,
      ).thenAnswer((_) => tHasConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockInternetConnection.hasInternetAccess);
      expect(result, tHasConnectionFuture);
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_out.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'log_in_test.mocks.dart';

void main() {
  late Logout usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = Logout(mockAuthRepository);
  });

  test('should call the logout method from the repository', () async {
    // Arrange
    when(mockAuthRepository.logout()).thenAnswer((_) async => Right(unit));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, const Right(unit));
    verify(mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

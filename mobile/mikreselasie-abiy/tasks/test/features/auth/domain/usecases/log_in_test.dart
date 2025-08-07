import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository repository;
  late LogIn usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = LogIn(repository);
  });

  const tName = 'name';
  const tEmail = 'email@gmail.com';
  const tPassword = 'password';
  const tAccessToken = 'token';
  const tUser = User(
    id: 'id',
    name: tName,
    email: tEmail,
    accessToken: tAccessToken,
  );

  test('should login using the repository', () async {
    when(
      repository.login(email: tEmail, password: tPassword),
    ).thenAnswer((_) async => const Right(tUser));

    final result = await usecase(const LogInParams(tEmail, tPassword));

    expect(result, const Right(tUser));
    verify(repository.login(email: tEmail, password: tPassword));
    verifyNoMoreInteractions(repository);
  });
}

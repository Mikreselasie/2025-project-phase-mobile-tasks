import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository repository;
  late SignUp usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = SignUp(repository);
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

  test('should register using the repository', () async {
    // arrange
    when(
      repository.register(name: tName, email: tEmail, password: tPassword),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(
      const SignUpParams(userName: tName, email: tEmail, password: tPassword),
    );

    // assert
    expect(result, const Right(tUser));
    verify(
      repository.register(name: tName, email: tEmail, password: tPassword),
    );
    verifyNoMoreInteractions(repository);
  });

  test('should return a failure when password is too short', () async {
    // arrange
    const tShortPassword = '123';

    // act
    final result = await usecase(
      const SignUpParams(
        userName: tName,
        email: tEmail,
        password: tShortPassword,
      ),
    );

    // assert
    expect(result, Left(AuthFailure.passwordTooShort()));
    verifyNever(
      repository.register(name: tName, email: tEmail, password: tShortPassword),
    );
  });
}

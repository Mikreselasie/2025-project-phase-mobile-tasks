import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/user_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_in_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late LogIn logIn;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    logIn = LogIn(mockUserRepository);
  });

  test("Should login using repository", () async {
    final tUser = User(
      email: "mikre@gmail.com",
      password: "123456",
      userName: "mikre98",
    );

    when(
      mockUserRepository.logIn(user: tUser),
    ).thenAnswer((_) async => Right(tUser));

    final result = await logIn(LogInParams(user: tUser));

    expect(result, Right(tUser));
    verify(mockUserRepository.logIn(user: tUser));
    verifyNoMoreInteractions(mockUserRepository);
  });
}

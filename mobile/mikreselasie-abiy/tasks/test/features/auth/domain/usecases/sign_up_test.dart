import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/user_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_in_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  late SignUp signUp;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    signUp = SignUp(mockUserRepository);
  });

  test("Should signUp using repository", () async {
    final tUser = User(
      email: "mikre@gmail.com",
      password: "123456",
      userName: "mikre98",
    );

    when(
      mockUserRepository.signUp(user: tUser),
    ).thenAnswer((_) async => Right(tUser));

    final result = await signUp(SignUpParams(user: tUser));

    expect(result, Right(tUser));
    verify(mockUserRepository.signUp(user: tUser));
    verifyNoMoreInteractions(mockUserRepository);
  });
}

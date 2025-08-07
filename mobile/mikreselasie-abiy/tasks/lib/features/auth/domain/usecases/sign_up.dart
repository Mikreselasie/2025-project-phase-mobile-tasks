import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';

class SignUp implements UseCase<void, SignUpParams> {
  final AuthRepository repository;

  const SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    if (params.password.length < 6) {
      return Left(AuthFailure.passwordTooShort());
    }

    return await repository.register(
      name: params.userName,
      email: params.email,
      password: params.password,
    );
  }
}

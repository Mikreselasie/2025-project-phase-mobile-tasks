import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/user_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';

class SignUp implements UseCase<void, SignUpParams> {
  final UserRepository repository;

  const SignUp(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    try {
      return await repository.signUp(user: params.user);
    } catch (e) {
      return Left(ServerFailure("Server Failure"));
    }
  }
}

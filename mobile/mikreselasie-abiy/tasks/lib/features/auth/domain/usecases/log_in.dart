import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/auth/domain/repositories/user_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';

class LogIn implements UseCase<void, LogInParams> {
  final UserRepository repository;

  const LogIn(this.repository);

  @override
  Future<Either<Failure, User>> call(LogInParams params) async {
    try {
      return await repository.logIn(user: params.user);
    } catch (e) {
      return Left(ServerFailure("Server Failure"));
    }
  }
}

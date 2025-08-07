import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/entities/authenticated_user.dart';
import 'package:ecommerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';

class LogIn implements UseCase<AuthenticatedUser, LogInParams> {
  final AuthRepository repository;

  const LogIn(this.repository);

  @override
  Future<Either<Failure, AuthenticatedUser>> call(LogInParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

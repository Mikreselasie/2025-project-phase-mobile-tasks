import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/domain/entities/authenticated_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthenticatedUser>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthenticatedUser>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, AuthenticatedUser>> getCurrentUser();
}

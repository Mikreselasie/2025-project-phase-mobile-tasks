import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, User>> getCurrentUser();
}

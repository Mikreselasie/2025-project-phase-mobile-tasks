import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> logIn({required User user});
}

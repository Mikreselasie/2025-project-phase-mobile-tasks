import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/authenticated_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/authenticated_user_model.dart';
import '../models/log_in_model.dart';
import 'package:ecommerce/core/network/http.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final HttpClient client;

  AuthRepositoryImpl({
    required this.client,
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthenticatedUser>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthenticatedUser>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final accessToken = await remoteDataSource.login(
          LoginModel(email: email, password: password),
        );

        client.authToken = accessToken.token;

        final user = await remoteDataSource.getCurrentUser();

        final authenticatedUser = AuthenticatedUserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          accessToken: accessToken.token,
        );

        await localDataSource.cacheUser(authenticatedUser);

        return Right(authenticatedUser);
      } on ServerException {
        return const Left(ServerFailure('Unable to login'));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthenticatedUser>> register({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

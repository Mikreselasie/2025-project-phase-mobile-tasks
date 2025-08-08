import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';

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
import 'package:flutter/foundation.dart'; // 👈 Needed for debugPrint

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
  Future<Either<Failure, AuthenticatedUser>> getCurrentUser() async {
    debugPrint('🔍 [AuthRepository] getCurrentUser called');
    if (await networkInfo.isConnected) {
      debugPrint('📶 Network connected');
      try {
        final user = await remoteDataSource.getCurrentUser();
        debugPrint('✅ Fetched current user: ${user.toString()}');
        return Right(user);
      } on ServerException catch (e) {
        debugPrint('❌ ServerException in getCurrentUser: ${e.message}');
        return const Left(ServerFailure('Unable to fetch user'));
      } catch (e) {
        debugPrint('❌ Unknown exception in getCurrentUser: $e');
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    } else {
      debugPrint('🚫 No network connection');
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUser>> login({
    required String email,
    required String password,
  }) async {
    debugPrint('🔐 [AuthRepository] login called with email: $email');
    if (await networkInfo.isConnected) {
      debugPrint('📶 Network connected');
      try {
        final accessToken = await remoteDataSource.login(
          LoginModel(email: email, password: password),
        );
        debugPrint('✅ Access token received: ${accessToken.token}');

        client.authToken = accessToken.token;

        final user = await remoteDataSource.getCurrentUser();
        debugPrint('✅ Logged in user fetched: ${user.toString()}');

        final authenticatedUser = AuthenticatedUserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          accessToken: accessToken.token,
        );

        await localDataSource.cacheUser(authenticatedUser);
        debugPrint('💾 Cached authenticated user');

        return Right(authenticatedUser);
      } on AuthenticationException catch (e) {
        debugPrint('❌ AuthenticationException in login: ${e.message}');
        return Left(ServerFailure(e.message)); // Use its message
      } on ServerException catch (e) {
        debugPrint('❌ ServerException in login: ${e.message}');
        return Left(ServerFailure(e.message));
      } catch (e) {
        debugPrint('❌ Unknown exception in login: $e');
        return Left(ServerFailure("Unexpected error occurred"));
      }
    } else {
      debugPrint('🚫 No network connection');
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    debugPrint('🚪 [AuthRepository] logout called');
    // You might want to clear cache, tokens, etc., here in the future
    return Future.value(const Right(unit));
  }

  @override
  Future<Either<Failure, AuthenticatedUser>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint('📝 [AuthRepository] register called with email: $email');
    if (await networkInfo.isConnected) {
      debugPrint('📶 Network connected');
      try {
        final user = await remoteDataSource.register(
          SignUpModel(name: name, email: email, password: password),
        );
        debugPrint('✅ User registered: ${user.toString()}');

        final authenticatedUser = AuthenticatedUserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          accessToken: '', // Access token should be handled after login
        );

        await localDataSource.cacheUser(authenticatedUser);
        debugPrint('💾 Cached registered user');

        return Right(authenticatedUser);
      } on ServerException catch (e) {
        debugPrint('❌ ServerException in register: ${e.message}');
        return Left(ServerFailure(e.message));
      } catch (e) {
        debugPrint('❌ Unknown exception in register: $e');
        return const Left(ServerFailure('Unexpected error occurred'));
      }
    } else {
      debugPrint('🚫 No network connection');
      return const Left(NetworkFailure());
    }
  }
}

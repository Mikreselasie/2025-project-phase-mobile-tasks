import 'dart:convert';

import 'package:ecommerce/features/auth/data/models/authenticated_user_model.dart';
import 'package:ecommerce/features/auth/data/models/log_in_model.dart';
import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/network/http.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final HttpClient client;
  final String _baseUrl;

  AuthRemoteDataSourceImpl({required this.client}) : _baseUrl = '$baseUrl/auth';

  @override
  Future<AccessToken> login(LoginModel loginModel) async {
    final response = await client.post(
      '$_baseUrl/login',
      loginModel.toJson(),
      headers: {},
      bodyText: "",
    );

    if (response.statusCode == 201) {
      return AccessToken.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 401) {
      throw AuthenticationException.invalidEmailAndPasswordCombination();
    } else if (response.statusCode == 503 ||
        response.body.contains('suspended')) {
      throw ServerException(
        message: 'Service is temporarily unavailable. Please try again later.',
      );
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<UserModel> register(SignUpModel registerModel) async {
    final response = await client.post(
      '$_baseUrl/register',
      registerModel.toJson(),
      headers: {},
      bodyText: "",
    );

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return UserModel.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 409) {
      throw AuthenticationException.emailAlreadyInUse();
    } else if (response.statusCode == 503 ||
        response.body.contains('suspended')) {
      throw ServerException(
        message: 'Service is temporarily unavailable. Please try again later.',
      );
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<AuthenticatedUserModel> getCurrentUser() async {
    final url = '$baseUrl/users/me';
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final user = AuthenticatedUserModel.fromJson(
        jsonDecode(response.body)['data'],
      );
      return user;
    } else if (response.statusCode == 401) {
      throw AuthenticationException.tokenExpired();
    } else if (response.statusCode == 503 ||
        response.body.contains('suspended')) {
      throw ServerException(
        message: 'Service is temporarily unavailable. Please try again later.',
      );
    } else {
      throw ServerException(message: response.body);
    }
  }
}

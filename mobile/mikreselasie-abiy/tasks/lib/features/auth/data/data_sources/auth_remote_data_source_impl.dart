import 'dart:convert';

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

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 409) {
      throw AuthenticationException.emailAlreadyInUse();
    } else {
      throw ServerException(message: response.body);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await client.get('$baseUrl/users/me');

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 401) {
      throw AuthenticationException.tokenExpired();
    } else {
      throw ServerException(message: response.body);
    }
  }
}

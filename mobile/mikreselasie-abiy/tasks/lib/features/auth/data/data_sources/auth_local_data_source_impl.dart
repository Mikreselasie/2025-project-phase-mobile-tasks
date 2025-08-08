import 'dart:convert';

import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce/features/auth/data/models/authenticated_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  final authCacheKey = 'AUTH';

  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> cacheUser(AuthenticatedUserModel user) {
    return _sharedPreferences.setString(
      authCacheKey,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<void> clear() {
    return _sharedPreferences.remove(authCacheKey);
  }

  @override
  Future<AuthenticatedUserModel> getUser() {
    final userJson = _sharedPreferences.getString(authCacheKey);
    if (userJson != null) {
      return Future.value(
        AuthenticatedUserModel.fromJson(jsonDecode(userJson)),
      );
    } else {
      throw const CacheException(message: 'User not found in cache');
    }
  }
}

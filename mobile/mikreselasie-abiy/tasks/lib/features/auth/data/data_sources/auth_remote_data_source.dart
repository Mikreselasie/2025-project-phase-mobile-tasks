import 'package:ecommerce/features/auth/data/models/log_in_model.dart';
import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AccessToken> login(LoginModel loginModel);
  Future<UserModel> register(SignUpModel registerModel);
  Future<UserModel> getCurrentUser();
}

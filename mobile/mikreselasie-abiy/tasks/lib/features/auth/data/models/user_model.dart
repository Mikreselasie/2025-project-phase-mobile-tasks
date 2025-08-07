import 'package:ecommerce/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.name,
    required super.id,
    required super.accessToken,
  });

  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(
      email: json["email"],
      name: json["name"],
      id: json["id"],
      accessToken: json["access_token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'access_token': accessToken,
    };
  }
}

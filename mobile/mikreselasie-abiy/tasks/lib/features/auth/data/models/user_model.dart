import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], email: json['email'], name: json['name']);
  }

  static UserModel fromEntity(User user) {
    return UserModel(id: user.id, email: user.email, name: user.name);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }

  @override
  List<Object> get props => [id, email, name];
}

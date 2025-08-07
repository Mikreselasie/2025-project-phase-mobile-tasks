import 'package:equatable/equatable.dart';

class User extends Equatable {
  final id;
  final email;
  final name;
  final accessToken;

  const User({
    required this.email,
    required this.name,
    required this.id,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [id, email, name, accessToken];
}

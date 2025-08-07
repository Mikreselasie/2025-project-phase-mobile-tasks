import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final email;
  final password;
  final userName;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object?> get props => [email, password, userName];
}

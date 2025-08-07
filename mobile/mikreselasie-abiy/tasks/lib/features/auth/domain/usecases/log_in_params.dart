import 'package:equatable/equatable.dart';

class LogInParams extends Equatable {
  final String email;
  final String password;

  const LogInParams(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

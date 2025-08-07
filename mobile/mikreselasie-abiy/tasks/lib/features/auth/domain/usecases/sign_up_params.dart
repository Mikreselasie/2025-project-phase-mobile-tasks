import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final User user;
  const SignUpParams({required this.user});

  @override
  List<Object?> get props => [user];
}

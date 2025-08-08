import 'package:ecommerce/features/auth/domain/entities/authenticated_user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthenticatedUser user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthTokenSaved extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {
  @override
  List<Object?> get props => [];
}

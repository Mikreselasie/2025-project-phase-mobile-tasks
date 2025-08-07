import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class LogInParams extends Equatable {
  final User user;

  const LogInParams({required this.user});
  @override
  List<Object?> get props => [user];
}

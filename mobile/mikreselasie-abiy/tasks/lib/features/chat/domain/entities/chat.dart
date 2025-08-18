import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final UserModel user1;
  final UserModel user2;

  const Chat({required this.id, required this.user1, required this.user2});

  @override
  List<Object?> get props => [id, user1, user2];
}

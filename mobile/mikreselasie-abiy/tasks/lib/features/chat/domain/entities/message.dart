import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final User sender;
  final Chat chat;
  final String type;

  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.chat,
    required this.type,
  });

  @override
  List<Object?> get props => [id, content, sender, chat, type];
}

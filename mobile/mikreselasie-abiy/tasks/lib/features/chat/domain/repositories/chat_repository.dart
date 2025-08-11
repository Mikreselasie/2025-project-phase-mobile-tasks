import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:ecommerce/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> getOrCreateChat(User receiver);
  Future<Stream<Either<Failure, Message>>> getChatMessages(String chatId);
  Future<Either<Failure, List<Chat>>> getUserChats();
  Future<Either<Failure, void>> sendMessage({
    required String id,
    required String message,
    required String type,
  });
}

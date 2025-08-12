import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/features/chat/data/models/chat_model.dart';
import 'package:ecommerce/features/chat/data/models/message_model.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';

abstract class ChatRemoteDataSource {
  Future<void> deleteChat(String id);
  Future<ChatModel> getOrCreateChat(UserModel receiver);
  Future<List<ChatModel>> getUserChats();
  void sendMessage(String chat, String message, String type);
  Stream<MessageModel> getChatMessages(String id);
  Future<Either<Failure, Chat>> initiateChat({
    required String userId,
    required String? initialMessage,
  });
}

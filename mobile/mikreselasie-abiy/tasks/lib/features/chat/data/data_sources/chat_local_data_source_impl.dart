import 'dart:convert';
import 'package:ecommerce/features/chat/data/models/chat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_local_data_source.dart';

const String CACHED_CHATS = 'CACHED_CHATS';

class ChatLocalDataSourceImpl extends ChatLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChatLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheChat(ChatModel chat) async {
    final chats = await getChats(); // Get current cached chats
    final updatedChats = [...chats, chat]; // Add new chat
    await cacheChats(updatedChats);
  }

  @override
  Future<void> cacheChats(List<ChatModel> chats) async {
    final chatJsonList = chats
        .map((chat) => jsonEncode(chat.toJson()))
        .toList();
    await sharedPreferences.setStringList(CACHED_CHATS, chatJsonList);
  }

  @override
  Future<ChatModel> getChat(String id) async {
    final chats = await getChats();
    try {
      return chats.firstWhere((chat) => chat.id == id);
    } catch (e) {
      throw Exception('Chat with id $id not found');
    }
  }

  @override
  Future<List<ChatModel>> getChats() async {
    final chatJsonList = sharedPreferences.getStringList(CACHED_CHATS);
    if (chatJsonList != null) {
      return chatJsonList
          .map(
            (chatString) => ChatModel.fromJson(
              jsonDecode(chatString) as Map<String, dynamic>,
            ),
          )
          .toList();
    }
    return [];
  }
}

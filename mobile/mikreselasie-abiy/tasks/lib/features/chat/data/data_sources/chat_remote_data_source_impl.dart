import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/exceptions.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/features/chat/data/models/chat_model.dart';
import 'package:ecommerce/features/chat/data/models/message_model.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/network/http.dart';
import 'chat_remote_data_source.dart';
import 'stream_socket.dart';

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final HttpClient client;
  final String _baseUrl;

  StreamSocket streamSocket = StreamSocket();

  ChatRemoteDataSourceImpl({required this.client})
    : _baseUrl = '$baseUrl/chats';

  @override
  Future<void> deleteChat(String id) async {
    try {
      final response = await client.delete('$_baseUrl/$id');

      if (response.statusCode != 200) {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Stream<MessageModel> getChatMessages(String id) {
    streamSocket.dispose();
    streamSocket = StreamSocket();

    client.get('$_baseUrl/$id/messages').then((response) {
      if (response.statusCode == 200) {
        final List<dynamic> messages = jsonDecode(response.body)['data'];

        for (var message in messages) {
          streamSocket.addResponse(MessageModel.fromJson(message));
        }
      } else {
        throw ServerException(message: response.body);
      }
    });

    client.socket.connect();

    client.socket.onConnect((_) {
      log('Connected to the socket server');
    });

    client.socket.onDisconnect((_) {
      log('Disconnected from the socket server');
    });

    client.socket.on('message:delivered', (data) {
      MessageModel message = MessageModel.fromJson(data);
      streamSocket.addResponse(message);
    });

    client.socket.on('message:received', (data) {
      MessageModel message = MessageModel.fromJson(data);
      streamSocket.addResponse(message);
    });

    return streamSocket.getResponse;
  }

  @override
  Future<ChatModel> getOrCreateChat(UserModel receiver) async {
    try {
      final response = await client.post(
        _baseUrl,
        {'userId': receiver.id},
        receiver.toJson(),
        bodyText: receiver.toJson().toString(),
      );

      if (response.statusCode == 200) {
        return ChatModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ChatModel>> getUserChats() async {
    try {
      final response = await client.get(_baseUrl);

      if (response.statusCode == 200) {
        final List<dynamic> chats = jsonDecode(response.body)['data'];
        return chats.map((e) => ChatModel.fromJson(e)).toList();
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  void sendMessage(String chat, String message, String type) {
    client.socket.emit('message:send', {
      'chatId': chat,
      'content': message,
      'type': type,
    });
  }

  @override
  Future<Either<Failure, Chat>> initiateChat({
    required String userId,
    required String? initialMessage,
  }) {
    if (userId.isEmpty) {
      return Future.value(Left(InvalidInputFailure('User ID cannot be empty')));
    }

    final completer = Completer<Either<Failure, Chat>>();
    final data = {'userId': userId, 'initialMessage': initialMessage ?? ''};

    // Emit the event to initiate chat
    client.socket.emit('chat:initiate', data);

    // Listen for the socket response event (replace 'chat:initiate:response' with your actual event)
    void listener(dynamic response) {
      try {
        // Parse your response into a Chat object
        final chat = ChatModel.fromJson(response); // assuming you have this

        // Complete the completer with success
        if (!completer.isCompleted) {
          completer.complete(Right(chat));
        }
      } catch (e) {
        // Complete with failure if parsing failed
        if (!completer.isCompleted) {
          completer.complete(Left(ServerFailure(e.toString())));
        }
      } finally {
        // Remove this listener to avoid memory leaks
        client.socket.off('chat:initiate:response', listener);
      }
    }

    client.socket.on('chat:initiate:response', listener);

    // Return the future that completes when the socket responds
    return completer.future;
  }
}

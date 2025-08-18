part of 'chat_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatsLoadRequested extends ChatsEvent {}

class ChatsChatInitiated extends ChatsEvent {
  final User receiver;

  const ChatsChatInitiated(this.receiver);

  @override
  List<Object> get props => [receiver];
}

class SearchUsersRequested extends ChatsEvent {
  final String query;
  SearchUsersRequested(this.query);
}

class InitiateChatRequested extends ChatsEvent {
  final String userId; // or username depending on your backend
  final String? initialMessage; // optional

  const InitiateChatRequested({required this.userId, this.initialMessage});
}

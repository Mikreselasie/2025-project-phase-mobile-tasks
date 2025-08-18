part of 'chat_bloc.dart';

sealed class ChatsState extends Equatable {
  final List<Chat> chats;

  const ChatsState({this.chats = const []});

  @override
  List<Object?> get props => [chats];
}

// ==== Base Chat States ====
class ChatsInitial extends ChatsState {
  const ChatsInitial({super.chats});
}

class ChatsLoadInProgress extends ChatsState {
  const ChatsLoadInProgress({super.chats});
}

class ChatsLoadSuccess extends ChatsState {
  const ChatsLoadSuccess({required super.chats});
}

class ChatsFailure extends ChatsState {
  final String message;

  const ChatsFailure(this.message, {super.chats});

  @override
  List<Object?> get props => [message, chats];
}

// ==== Chat Creation/Deletion ====
class ChatsInitiateInProgress extends ChatsState {
  const ChatsInitiateInProgress(List<Chat> chats) : super(chats: chats);
}

class ChatsInitiateSuccess extends ChatsState {
  final Chat addedChat;

  const ChatsInitiateSuccess(this.addedChat, {super.chats});

  @override
  List<Object?> get props => [addedChat, chats];
}

class ChatsDeleteInProgress extends ChatsState {
  const ChatsDeleteInProgress({super.chats});
}

class ChatsDeleteSuccess extends ChatsState {
  final String deletedChatName;

  const ChatsDeleteSuccess(this.deletedChatName, {super.chats});

  @override
  List<Object?> get props => [deletedChatName, chats];
}

// ==== Search States ====
class UsersSearchInProgress extends ChatsState {
  const UsersSearchInProgress({super.chats});
}

class UsersSearchSuccess extends ChatsState {
  final List<User> results;

  const UsersSearchSuccess(this.results, {super.chats});

  @override
  List<Object?> get props => [results, chats];
}

class UsersSearchFailure extends ChatsState {
  final String message;

  const UsersSearchFailure(this.message, {super.chats});

  @override
  List<Object?> get props => [message, chats];
}

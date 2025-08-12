import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/entities/user.dart';
import 'package:ecommerce/features/chat/domain/entities/chat.dart';
import 'package:ecommerce/features/chat/domain/usecases/get_my_chats.dart';
import 'package:ecommerce/features/chat/domain/usecases/initiate_chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetMyChats getMyChats;
  final InitiateChat initiateChat;

  ChatsBloc({required this.getMyChats, required this.initiateChat})
    : super(const ChatsInitial([])) {
    on<ChatsLoadRequested>(_onLoadChatsRequested);
    on<ChatsChatInitiated>(_onChatAdded);
  }

  Future<void> _onLoadChatsRequested(
    ChatsLoadRequested event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadInProgress(state.chats));

    final chats = await getMyChats(NoParams());

    chats.fold(
      (failure) => emit(ChatsFailure(failure.message, state.chats)),
      (chats) => emit(ChatsLoadSuccess(chats)),
    );
  }

  Future<void> _onChatAdded(
    ChatsChatInitiated event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsInitiateInProgress(state.chats));

    final result = await initiateChat(InitiateChatParams(event.receiver));

    result.fold(
      (failure) => emit(ChatsFailure(failure.message, state.chats)),
      (chat) => emit(ChatsInitiateSuccess(chat, state.chats)),
    );
  }
}

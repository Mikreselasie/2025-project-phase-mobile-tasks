import 'package:ecommerce/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/usecases/get_my_chats.dart';
import '../../../domain/usecases/initiate_chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetMyChats getMyChats;
  final InitiateChat initiateChat;
  final ChatRepository chatRepository;

  ChatsBloc(
    this.chatRepository, {
    required this.getMyChats,
    required this.initiateChat,
  }) : super(const ChatsInitial(chats: [])) {
    on<ChatsLoadRequested>(_onLoadChatsRequested);
    on<ChatsChatInitiated>(_onChatAdded);
    on<InitiateChatRequested>(_onInitiateChatRequested);
  }

  Future<void> _onLoadChatsRequested(
    ChatsLoadRequested event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsLoadInProgress(chats: state.chats));

    final chats = await getMyChats(NoParams());

    chats.fold(
      (failure) => emit(ChatsFailure(failure.message, chats: state.chats)),
      (chats) => emit(ChatsLoadSuccess(chats: chats)),
    );
  }

  Future<void> _onChatAdded(
    ChatsChatInitiated event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsInitiateInProgress(state.chats));

    final result = await initiateChat(InitiateChatParams(event.receiver));

    result.fold(
      (failure) => emit(ChatsFailure(failure.message, chats: state.chats)),
      (chat) => emit(ChatsInitiateSuccess(chat, chats: [...state.chats, chat])),
    );
  }

  Future<void> _onInitiateChatRequested(
    InitiateChatRequested event,
    Emitter<ChatsState> emit,
  ) async {
    emit(ChatsInitiateInProgress(state.chats));

    try {
      final result = await chatRepository.initiateChat(
        userId: event.userId,
        initialMessage: event.initialMessage,
      );

      result.fold(
        (failure) {
          // Failure case
          emit(ChatsFailure(failure.toString(), chats: state.chats));
        },
        (newChat) {
          // Success case
          emit(ChatsInitiateSuccess(newChat, chats: [...state.chats, newChat]));
        },
      );
    } catch (e) {
      // Handle unexpected exceptions
      emit(ChatsFailure(e.toString(), chats: state.chats));
    }
  }
}

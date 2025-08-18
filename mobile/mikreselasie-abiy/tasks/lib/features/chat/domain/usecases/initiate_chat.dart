import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';
import '../entities/chat.dart';

import '../repositories/chat_repository.dart';

class InitiateChat implements UseCase<Chat, InitiateChatParams> {
  final ChatRepository repository;

  const InitiateChat(this.repository);

  @override
  Future<Either<Failure, Chat>> call(InitiateChatParams params) async {
    return await repository.getOrCreateChat(params.receiver);
  }
}

class InitiateChatParams extends Equatable {
  final User receiver;

  const InitiateChatParams(this.receiver);

  @override
  List<Object?> get props => [receiver];
}

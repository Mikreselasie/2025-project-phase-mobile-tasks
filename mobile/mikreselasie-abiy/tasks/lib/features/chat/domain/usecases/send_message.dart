import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import '../entities/chat.dart';

import '../repositories/chat_repository.dart';

class SendMessage implements UseCase<Unit, SendMessageParams> {
  final ChatRepository repository;

  const SendMessage(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SendMessageParams params) async {
    return await repository
        .sendMessage(
          id: params.chat.id,
          message: params.message,
          type: params.type,
        )
        .then((either) => either.map((_) => unit));
  }
}

class SendMessageParams extends Equatable {
  final Chat chat;
  final String message;
  final String type;

  const SendMessageParams(this.chat, this.message, this.type);

  @override
  List<Object?> get props => [chat, message, type];
}

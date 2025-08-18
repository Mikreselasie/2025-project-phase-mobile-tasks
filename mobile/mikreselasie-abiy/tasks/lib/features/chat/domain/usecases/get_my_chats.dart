import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/errors/failures.dart';
import 'package:ecommerce/core/usecases/usecase.dart';

import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetMyChats implements UseCase<List<Chat>, NoParams> {
  final ChatRepository repository;

  const GetMyChats(this.repository);

  @override
  Future<Either<Failure, List<Chat>>> call(NoParams params) async {
    return await repository.getUserChats();
  }
}

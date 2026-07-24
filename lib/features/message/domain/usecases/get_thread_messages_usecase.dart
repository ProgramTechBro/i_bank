import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/message_repository.dart';
import '../entities/chat_message_entity.dart';

@injectable
class GetThreadMessagesUseCase {
  final MessageRepository repository;
  const GetThreadMessagesUseCase(this.repository);

  Future<Either<Failure, List<ChatMessageEntity>>> call() =>
      repository.getThreadMessages();
}

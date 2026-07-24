import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/message_repository.dart';
import '../entities/chat_message_entity.dart';

@injectable
class SendThreadMessageUseCase {
  final MessageRepository repository;
  const SendThreadMessageUseCase(this.repository);

  Future<Either<Failure, ChatMessageEntity>> call(String text) =>
      repository.sendThreadMessage(text);
}

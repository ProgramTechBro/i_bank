import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<MessageEntity>>> getMessages();

  Future<Either<Failure, List<ChatMessageEntity>>> getThreadMessages();

  Future<Either<Failure, ChatMessageEntity>> sendThreadMessage(String text);
}

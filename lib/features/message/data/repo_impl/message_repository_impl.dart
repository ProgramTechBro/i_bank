import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../datasources/local/message_local_datasource.dart';
import '../repo/message_repository.dart';

@LazySingleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final MessageLocalDatasource localDatasource;
  const MessageRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages() async {
    try {
      final messages = await localDatasource.getMessages();
      return Right(messages);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getThreadMessages() async {
    try {
      final messages = await localDatasource.getThreadMessages();
      return Right(messages);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendThreadMessage(
    String text,
  ) async {
    try {
      final message = await localDatasource.sendThreadMessage(text);
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

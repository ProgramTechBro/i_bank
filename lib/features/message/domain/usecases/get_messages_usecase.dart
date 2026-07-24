import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/message_repository.dart';
import '../entities/message_entity.dart';

@injectable
class GetMessagesUseCase {
  final MessageRepository repository;
  const GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<MessageEntity>>> call() =>
      repository.getMessages();
}

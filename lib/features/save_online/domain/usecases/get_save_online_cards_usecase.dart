import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/save_online_repository.dart';
import '../entities/save_online_card_entity.dart';

@injectable
class GetSaveOnlineCardsUseCase {
  final SaveOnlineRepository repository;
  const GetSaveOnlineCardsUseCase(this.repository);

  Future<Either<Failure, List<SaveOnlineCardEntity>>> call() =>
      repository.getCards();
}

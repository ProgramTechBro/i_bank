import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/managed_save_entity.dart';
import '../../domain/entities/save_online_card_entity.dart';
import '../../domain/entities/save_online_request_entity.dart';
import '../../domain/entities/time_deposit_option_entity.dart';

abstract class SaveOnlineRepository {
  Future<Either<Failure, List<SaveOnlineCardEntity>>> getCards();

  Future<Either<Failure, List<TimeDepositOptionEntity>>>
  getTimeDepositOptions();

  Future<Either<Failure, Unit>> submitSaveOnline(
    SaveOnlineRequestEntity request,
  );

  Future<Either<Failure, List<ManagedSaveEntity>>> getManagedSaves();
}

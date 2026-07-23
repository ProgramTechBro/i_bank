import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/managed_save_entity.dart';
import '../../domain/entities/save_online_card_entity.dart';
import '../../domain/entities/save_online_request_entity.dart';
import '../../domain/entities/time_deposit_option_entity.dart';
import '../datasources/local/save_online_local_datasource.dart';
import '../repo/save_online_repository.dart';

@LazySingleton(as: SaveOnlineRepository)
class SaveOnlineRepositoryImpl implements SaveOnlineRepository {
  final SaveOnlineLocalDatasource localDatasource;
  const SaveOnlineRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<SaveOnlineCardEntity>>> getCards() async {
    try {
      final cards = await localDatasource.getCards();
      return Right(cards);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TimeDepositOptionEntity>>>
  getTimeDepositOptions() async {
    try {
      final options = await localDatasource.getTimeDepositOptions();
      return Right(options);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitSaveOnline(
    SaveOnlineRequestEntity request,
  ) async {
    try {
      await localDatasource.submitSaveOnline(request);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ManagedSaveEntity>>> getManagedSaves() async {
    try {
      final saves = await localDatasource.getManagedSaves();
      return Right(saves);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

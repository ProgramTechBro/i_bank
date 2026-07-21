import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/language_entity.dart';
import '../datasources/local/settings_local_datasource.dart';
import '../repo/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource localDatasource;
  const SettingsRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<LanguageEntity>>> getLanguages() async {
    try {
      final result = await localDatasource.getLanguages();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

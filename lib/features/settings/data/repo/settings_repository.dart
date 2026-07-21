import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/language_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, List<LanguageEntity>>> getLanguages();
}

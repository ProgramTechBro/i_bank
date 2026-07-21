import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/settings_repository.dart';
import '../entities/language_entity.dart';

@injectable
class GetLanguagesUseCase {
  final SettingsRepository repository;
  const GetLanguagesUseCase(this.repository);

  Future<Either<Failure, List<LanguageEntity>>> call() =>
      repository.getLanguages();
}

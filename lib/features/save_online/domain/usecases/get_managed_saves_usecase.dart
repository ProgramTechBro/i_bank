import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/save_online_repository.dart';
import '../entities/managed_save_entity.dart';

@injectable
class GetManagedSavesUseCase {
  final SaveOnlineRepository repository;
  const GetManagedSavesUseCase(this.repository);

  Future<Either<Failure, List<ManagedSaveEntity>>> call() =>
      repository.getManagedSaves();
}

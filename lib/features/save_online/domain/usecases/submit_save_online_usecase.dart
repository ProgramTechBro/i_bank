import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/save_online_repository.dart';
import '../entities/save_online_request_entity.dart';

@injectable
class SubmitSaveOnlineUseCase {
  final SaveOnlineRepository repository;
  const SubmitSaveOnlineUseCase(this.repository);

  Future<Either<Failure, Unit>> call(SaveOnlineRequestEntity request) =>
      repository.submitSaveOnline(request);
}

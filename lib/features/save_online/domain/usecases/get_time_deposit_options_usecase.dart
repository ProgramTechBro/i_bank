import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/save_online_repository.dart';
import '../entities/time_deposit_option_entity.dart';

@injectable
class GetTimeDepositOptionsUseCase {
  final SaveOnlineRepository repository;
  const GetTimeDepositOptionsUseCase(this.repository);

  Future<Either<Failure, List<TimeDepositOptionEntity>>> call() =>
      repository.getTimeDepositOptions();
}

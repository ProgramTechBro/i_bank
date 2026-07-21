import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/branch_locator_repository.dart';
import '../entities/interest_rate_entity.dart';

@injectable
class GetInterestRatesUseCase {
  final BranchLocatorRepository repository;
  const GetInterestRatesUseCase(this.repository);

  Future<Either<Failure, List<InterestRateEntity>>> call() =>
      repository.getInterestRates();
}

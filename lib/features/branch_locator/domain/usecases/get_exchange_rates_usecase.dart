import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/branch_locator_repository.dart';
import '../entities/exchange_rate_entity.dart';

@injectable
class GetExchangeRatesUseCase {
  final BranchLocatorRepository repository;
  const GetExchangeRatesUseCase(this.repository);

  Future<Either<Failure, List<ExchangeRateEntity>>> call() =>
      repository.getExchangeRates();
}

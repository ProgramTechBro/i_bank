import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/branch_entity.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/entities/interest_rate_entity.dart';

abstract class BranchLocatorRepository {
  Future<Either<Failure, List<BranchEntity>>> getBranches();

  Future<Either<Failure, List<InterestRateEntity>>> getInterestRates();

  Future<Either<Failure, List<ExchangeRateEntity>>> getExchangeRates();
}

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/branch_entity.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/entities/interest_rate_entity.dart';
import '../datasources/local/branch_locator_local_datasource.dart';
import '../repo/branch_locator_repository.dart';

@LazySingleton(as: BranchLocatorRepository)
class BranchLocatorRepositoryImpl implements BranchLocatorRepository {
  final BranchLocatorLocalDatasource localDatasource;
  const BranchLocatorRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<BranchEntity>>> getBranches() =>
      _run(localDatasource.getBranches);

  @override
  Future<Either<Failure, List<InterestRateEntity>>> getInterestRates() =>
      _run(localDatasource.getInterestRates);

  @override
  Future<Either<Failure, List<ExchangeRateEntity>>> getExchangeRates() =>
      _run(localDatasource.getExchangeRates);

  Future<Either<Failure, List<T>>> _run<T>(
    Future<List<T>> Function() action,
  ) async {
    try {
      final result = await action();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
